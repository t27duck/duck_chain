# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "duck_chain/version"

Gem::Specification.new do |s|
  s.name        = "duck_chain"
  s.version     = DuckChain::VERSION
  
  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=

  s.authors     = ["Tony Drake"]
  s.email       = ["t27duck@gmail.com"]
  # s.homepage    = ""
  s.summary     = %q{Because I like chaining easy to read search methods with ActiveRecord thankyouverymuch}
  s.description = %q{A simple Rails 3 Gem that extends ActiveRecord. Let's you specify model attributes to dynamically create search methods similar to searchlogic's dynamic named scopes. It can be used to help Rails 2 projects with searchlogic migrate to Rails 3 with metasearch a little easier.}

  s.rubyforge_project = "duck_chain"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency(%q<activerecord>, [">= 3.0.0"])
end
