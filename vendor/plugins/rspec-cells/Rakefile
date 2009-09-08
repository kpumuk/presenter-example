require 'rake'
require 'spec/rake/spectask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :spec

desc 'Test the rspec-cells plugin.'
Spec::Rake::SpecTask.new(:spec) do |t|
  t.libs << 'lib'
  t.pattern = 'spec/**/*_spec.rb'
  t.verbose = true
  t.spec_opts = ['-cfs']
end

desc 'Generate documentation for the rspec-cells plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'rspec-cells'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc', 'MIT-LICENSE')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
