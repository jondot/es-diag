# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "es-diag/version"

Gem::Specification.new do |s|
  s.name        = "es-diag"
  s.version     = ES::Diag::VERSION
  s.authors     = ["Dotan Nahum"]
  s.email       = ["jondotan@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Elastic Search diagnostics tool}
  s.description = %q{Elastic Search diagnostics tool}

  s.rubyforge_project = "es-diag"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "thor"
  s.add_runtime_dependency "ohai"
  s.add_runtime_dependency "hashie"
end
