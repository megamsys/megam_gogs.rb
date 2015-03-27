# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "megam/gogs/version"

Gem::Specification.new do |s|
  s.name        = "megam_gogs"
  s.version     = Megam::Gogs::VERSION
  s.authors     = ["Raj Thilak,Kishorekumar Neelamegam, Thomas Alrin, Yeshwanth Kumar"]
  s.email       = ["rajthilak@megam.co.in","nkishore@megam.co.in","alrin@megam.co.in, getyesh@megam.co.in"]
  s.homepage    = "http://github.com/megamsys/megam_gogs.rb"
  s.license = "Apache V2"
  sextra_rdoc_files = ["README.md", "LICENSE" ]
  s.summary     = %q{Ruby Client for the Gogs (gogs.io)}
  s.description = %q{Ruby Client for the Gogs (gogs.io). Performs REST based HTTP call to gogs.io server}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,fea,tures}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_runtime_dependency 'highline', '~> 1.6'
  s.add_runtime_dependency 'nokogiri', '~> 1.6'
  s.add_development_dependency 'minitest', '~> 5.2'
  s.add_development_dependency 'rake', '~> 10.1'
end
