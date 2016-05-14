#!/bin/bash

# Copied from:
# https://raw.githubusercontent.com/zuazo/kitchen-in-travis/master/scripts/start_docker.sh
#
# Installs and starts Docker Engine inside Travis CI using User Mode Linux
#

# Exit immediately if a simple command exits with a non-zero status
set -e

# Some travis bash functions
ANSI_RED="${ANSI_RED:-\e[31;1m}"
ANSI_YELLOW="${ANSY_YELLOW:-\e[33;1m}"
ANSI_RESET="${ANSI_RESET:-\e[0m}"
if ! type travis_fold &> /dev/null
then
  travis_fold() {
    local ACTION="${1}"
    local NAME="${2}"
    echo "${NAME} ${ACTION}"
    if [ x"${ACTION}" == x'end' ]
    then
      echo
    fi
  }
fi
if ! type travis_retry &> /dev/null
then
  travis_retry() {
    local RESULT=0
    local COUNT=1
    while [ "${COUNT}" -le 3 ]; do
      if [ "${RESULT}" -ne 0 ]
      then
        echo -e "\n${ANSI_RED}The command \"$@\" failed. Retrying, $COUNT of 3.${ANSI_RESET}\n" >&2
      fi
      "$@"
      RESULT="$?"
      [ "${RESULT}" -eq 0 ] && break
      COUNT="$(($COUNT + 1))"
      sleep 1
    done
    if [ $COUNT -gt 3 ]
    then
      echo -e "\n${ANSI_RED}The command \"$@\" failed 3 times.${ANSI_RESET}\n" >&2
    fi
    return $RESULT
 }
fi

travis_section() {
  echo -e "${ANSI_YELLOW}${*}${ANSI_RESET}"
}

# Define some environment variables
travis_fold start env.setup
  travis_section 'Setting environment variables for Docker'
  SLIRP_HOST="$(ip addr | awk '/scope global/ {print $2; exit}' | cut -d/ -f1)"
  SLIRP_MIN_PORT='2375'
  SLIRP_MAX_PORT='2400'
  SLIRP_PORTS="$(seq "${SLIRP_MIN_PORT}" "${SLIRP_MAX_PORT}")"
  DOCKER_HOST="tcp://${SLIRP_HOST}:${SLIRP_MIN_PORT}"
  DOCKER_PORT_RANGE="$((SLIRP_MIN_PORT+1)):${SLIRP_MAX_PORT}"
  export SLIRP_HOST DOCKER_HOST DOCKER_PORT_RANGE SLIRP_PORTS
  echo "SLIRP_HOST=${SLIRP_HOST}"
  echo "DOCKER_HOST=${DOCKER_HOST}"
  echo "DOCKER_PORT_RANGE=${DOCKER_PORT_RANGE}"
travis_fold end env.setup
echo

travis_fold start curl.install
  travis_section 'Installing cURL'
  sudo apt-get -y update
  sudo apt-get install -y ca-certificates curl
travis_fold end curl.install
echo

travis_fold start docker.repository.install
  travis_section 'Installing docker repository'
  curl https://get.docker.com/gpg | sudo apt-key add -
  echo 'deb https://get.docker.io/ubuntu docker main' | sudo tee /etc/apt/sources.list.d/docker.list
travis_fold end docker.repository.install
echo

travis_fold start apparmor.reinstall
  travis_section "Reinstalling AppArmor (Could not open 'tunables/global')"
  sudo apt-get -o Dpkg::Options::=--force-confnew -o Dpkg::Options::=--force-confmiss --reinstall install apparmor
travis_fold end apparmor.reinstall
echo

travis_fold start apt.policy.setup
  travis_section 'Preventing APT from starting any service'
  echo exit 101 | sudo tee /usr/sbin/policy-rc.d
  sudo chmod +x /usr/sbin/policy-rc.d
travis_fold end apt.policy.setup
echo

travis_fold start docker.install
  travis_section 'Installing Docker'
  sudo apt-get -y update
  sudo apt-get -y install lxc lxc-docker slirp
  sudo usermod -aG docker "${USER}"
  sudo service docker stop || true
travis_fold end docker.install
echo

travis_fold start uml.download
  travis_section 'Downloading User Mode Linux scripts'
  if ! [ -e sekexe ]
  then
    travis_retry git clone git://github.com/cptactionhank/sekexe
  fi
travis_fold end uml.download
echo

travis_fold start docker.start
  travis_section 'Starting Docker Engine'
  cat > run-uml.sh << EOF
sekexe/run "
  echo ${SLIRP_MIN_PORT} ${SLIRP_MAX_PORT} > /proc/sys/net/ipv4/ip_local_port_range && \\
  docker daemon -H tcp://0.0.0.0:${SLIRP_MIN_PORT}
"
EOF
  chmod +x run-uml.sh
  if [ "${DOCKER_DEBUG}"x = 'true'x ]
  then
    ./run-uml.sh 2>&1 | tee -a docker_daemon.log &
  else
    ./run-uml.sh &> docker_daemon.log &
  fi
travis_fold end docker.start
echo

travis_fold start docker.wait
  travis_section 'Waiting for Docker to start'
  TIME=0
  while ! docker info &> /dev/null
  do
    [ "${TIME}" -gt 60 ] && exit 1
    echo -n .
    sleep 1
    TIME="$((TIME+1))"
  done
travis_fold end docker.wait
echo

travis_section 'Docker version:'
docker version
echo
