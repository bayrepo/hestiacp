Gem::Specification.new do |spec|
  spec.name = "envbash"
  spec.summary = "Source env.bash script to update environment"
  spec.version = "1.0.1"
  spec.authors = ["Aron Griffis"]
  spec.email = "aron@scampersand.com"
  spec.homepage = "https://github.com/scampersand/envbash-ruby"
  spec.licenses = ["MIT"]

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "codecov"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-assert_errors"
  spec.add_development_dependency "rake"
end
