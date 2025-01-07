require 'rake/testtask'

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  # make sure helper.rb is loaded first, to start simplecov
  test.test_files = FileList['test/helper.rb', 'test/test*.rb']
end

task :default => :test

# this adds "rake build" to make pkg/envbash-*.gem
require 'bundler/setup'
Bundler::GemHelper.install_tasks
