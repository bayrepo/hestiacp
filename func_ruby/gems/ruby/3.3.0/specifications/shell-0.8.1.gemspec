# -*- encoding: utf-8 -*-
# stub: shell 0.8.1 ruby lib

Gem::Specification.new do |s|
  s.name = "shell".freeze
  s.version = "0.8.1".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Keiju ISHITSUKA".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-07-16"
  s.description = "An idiomatic Ruby interface for common UNIX shell commands.".freeze
  s.email = ["keiju@ruby-lang.org".freeze]
  s.homepage = "https://github.com/ruby/shell".freeze
  s.licenses = ["BSD-2-Clause".freeze]
  s.rubygems_version = "3.2.0.pre1".freeze
  s.summary = "An idiomatic Ruby interface for common UNIX shell commands.".freeze

  s.installed_by_version = "3.5.16".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<e2mmap>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<sync>.freeze, [">= 0".freeze])
end
