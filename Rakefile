require 'rubocop/rake_task'

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['providers','resources','test/integration/default/serverspec']
  task.options = ['--display-cop-names']
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
