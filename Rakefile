require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "em-redfinger"
    gem.summary = %Q{A Ruby WebFinger client.}
    gem.description = %Q{A Ruby Webfinger client}
    gem.email = "oz@cyprio.net"
    gem.homepage = "http://github.com/oz/em-redfinger"
    gem.authors = ["Michael Bleigh", "Arnaud Berthomier"]
    gem.add_dependency(%q<em-http-request>, ">= 1.0.0")
    gem.add_dependency(%q<em-http-request>, ">= 1.0.0")
    gem.add_dependency "nokogiri", ">= 1.4.0"
    gem.add_dependency "hashie"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.rcov = true
end

task :spec => :check_dependencies
task :default => :spec
