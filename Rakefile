require 'bundler/gem_tasks'

require 'rdoc/task'
desc 'Generate RDoc documentation for the will_paginate plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_files.include('README.rdoc', 'LICENSE', 'CHANGELOG.rdoc').include('lib/**/*.rb').exclude('lib/duck_chain/version.rb')
  
  rdoc.main = "README.rdoc" # page to start on
  rdoc.title = "duck_chain documentation"
  
  rdoc.rdoc_dir = 'doc' # rdoc output folder
  rdoc.options << '--inline-source' << '--charset=UTF-8'
end
