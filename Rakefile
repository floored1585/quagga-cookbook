require 'rubocop/rake_task'

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['providers','resources','recipes','test/integration/' ]
  task.options = ['--display-cop-names']
end

# Rakefile
require 'bundler/setup'

# [...]

desc 'Run Test Kitchen integration tests'
namespace :integration do
  desc 'Run integration tests with kitchen-docker'
  task :docker do
    require 'kitchen'
    Kitchen.logger = Kitchen.default_file_logger
    @loader = Kitchen::Loader::YAML.new(local_config: '.kitchen.docker.yml')
    Kitchen::Config.new(loader: @loader).instances.each do |instance|
      instance.test(:always)
    end
  end
end

begin
  require 'berkshelf'
  require 'kitchen/rake_tasks'

  Kitchen::RakeTasks.new

  desc "Install Berkshelf cookbooks for testing"
  task :berks_install do
    begin
      berksfile = Berkshelf::Berksfile.from_file("Berksfile")
      berksfile.install
    rescue StandardError => e
      STDERR.puts("Failed to install Chef cookbooks: #{e.message}")
    end
  end

  desc "Converge and run tests"
  task :test => [:berks_install, 'kitchen:all'] do
  end
rescue LoadError
  puts "Couldn't load test-kitchen: kitchen tests are not available"
end
