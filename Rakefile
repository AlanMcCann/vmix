# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "vmix"
  gem.homepage = "http://github.com/alanmccann/vmix"
  gem.license = "MIT"
  gem.summary = %Q{Ruby Client for VMIX REST API}
  gem.description = %Q{Ruby Client for VMIX REST API}
  gem.email = "alan@imccann.com"
  gem.authors = ["Alan McCann"]
  # dependencies defined in Gemfile
  gem.add_dependency "httparty", "~> 0.10.0"

  gem.add_development_dependency "rake", "~> 0.9.2.2"
  gem.add_development_dependency "rspec", "~> 2.12"
  gem.add_development_dependency "webmock", "~> 1.9.0"
end

Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

# require 'rcov/rcovtask'
# Rcov::RcovTask.new do |test|
#   test.libs << 'test'
#   test.pattern = 'test/**/test_*.rb'
#   test.verbose = true
#   test.rcov_opts << '--exclude "gems/*"'
# end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "vmix #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
