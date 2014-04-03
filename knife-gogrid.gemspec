# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = "knife-gogrid"
  s.version = "0.1.0"
  s.authors = ["Kishorekumar Neelamegam, Rajthilak"]
  s.email = ["nkishore@megam.co.in","rajthilak@megam.co.in"]
  s.homepage = "http://github.com/megamsys/knife-gogrid"
  s.license = "Apache V2"
  s.extra_rdoc_files = ["README.md", "LICENSE" ]
  s.summary = %q{Knife Client for GoGrid cloud}
  s.description = %q{Knife Client for GoGrid cloud. If you wish to use Chef with GoGrid an awesome cloud}
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]  
  s.add_runtime_dependency 'chef'
end