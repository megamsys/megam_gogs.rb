# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "megam/scmmanager/version"

Gem::Specification.new do |s|
  s.name        = "megam_scmmanager"
  s.version     = Megam::Scmmanager::VERSION
  s.authors     = ["Raj Thilak,Kishorekumar Neelamegam, Thomas Alrin"]
  s.email       = ["rajthilak@megam.co.in","nkishore@megam.co.in","alrin@megam.co.in"]
  s.homepage    = "http://github.com/indykish/megam_scmmanager.rb"
  s.license = "Apache V2"
  sextra_rdoc_files = ["README.md", "LICENSE" ]
  s.summary     = %q{Ruby Client for the Scm-manager (scm-manager.org)}
  s.description = %q{Ruby Client for the Scm-manager (scm-manager.org). Performs REST based HTTP call to scm-manager.org server}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,fea,tures}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_runtime_dependency 'highline', '~> 1.6'
  s.add_runtime_dependency 'nokogiri', '~> 1.6'
  s.add_development_dependency 'minitest', '~> 5.2'
  s.add_development_dependency 'rake', '~> 10.1'
end
