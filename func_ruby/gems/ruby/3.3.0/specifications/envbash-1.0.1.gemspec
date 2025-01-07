# -*- encoding: utf-8 -*-
# stub: envbash 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "envbash".freeze
  s.version = "1.0.1".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Aron Griffis".freeze]
  s.date = "2017-02-18"
  s.email = "aron@scampersand.com".freeze
  s.homepage = "https://github.com/scampersand/envbash-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Source env.bash script to update environment".freeze

  s.installed_by_version = "3.5.16".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<codecov>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<minitest>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<minitest-assert_errors>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
end
