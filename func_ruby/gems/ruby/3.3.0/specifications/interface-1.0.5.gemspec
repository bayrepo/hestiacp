# -*- encoding: utf-8 -*-
# stub: interface 1.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "interface".freeze
  s.version = "1.0.5".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/djberg96/interface/issues", "changelog_uri" => "https://github.com/djberg96/interface/blob/master/CHANGES", "documentation_uri" => "https://github.com/djberg96/interface/wiki", "homepage_uri" => "https://github.com/djberg96/interface", "source_code_uri" => "https://github.com/djberg96/interface", "wiki_uri" => "https://github.com/djberg96/interface/wiki" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Daniel J. Berger".freeze]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIEcDCCAtigAwIBAgIBATANBgkqhkiG9w0BAQsFADA/MREwDwYDVQQDDAhkamJl\ncmc5NjEVMBMGCgmSJomT8ixkARkWBWdtYWlsMRMwEQYKCZImiZPyLGQBGRYDY29t\nMB4XDTE4MDMxODE1MjIwN1oXDTI4MDMxNTE1MjIwN1owPzERMA8GA1UEAwwIZGpi\nZXJnOTYxFTATBgoJkiaJk/IsZAEZFgVnbWFpbDETMBEGCgmSJomT8ixkARkWA2Nv\nbTCCAaIwDQYJKoZIhvcNAQEBBQADggGPADCCAYoCggGBALgfaroVM6CI06cxr0/h\nA+j+pc8fgpRgBVmHFaFunq28GPC3IvW7Nvc3Y8SnAW7pP1EQIbhlwRIaQzJ93/yj\nu95KpkP7tA9erypnV7dpzBkzNlX14ACaFD/6pHoXoe2ltBxk3CCyyzx70mTqJpph\n75IB03ni9a8yqn8pmse+s83bFJOAqddSj009sGPcQO+QOWiNxqYv1n5EHcvj2ebO\n6hN7YTmhx7aSia4qL/quc4DlIaGMWoAhvML7u1fmo53CYxkKskfN8MOecq2vfEmL\niLu+SsVVEAufMDDFMXMJlvDsviolUSGMSNRTujkyCcJoXKYYxZSNtIiyd9etI0X3\nctu0uhrFyrMZXCedutvXNjUolD5r9KGBFSWH1R9u2I3n3SAyFF2yzv/7idQHLJJq\n74BMnx0FIq6fCpu5slAipvxZ3ZkZpEXZFr3cIBtO1gFvQWW7E/Y3ijliWJS1GQFq\n058qERadHGu1yu1dojmFRo6W2KZvY9al2yIlbkpDrD5MYQIDAQABo3cwdTAJBgNV\nHRMEAjAAMAsGA1UdDwQEAwIEsDAdBgNVHQ4EFgQUFZsMapgzJimzsbaBG2Tm8j5e\nAzgwHQYDVR0RBBYwFIESZGpiZXJnOTZAZ21haWwuY29tMB0GA1UdEgQWMBSBEmRq\nYmVyZzk2QGdtYWlsLmNvbTANBgkqhkiG9w0BAQsFAAOCAYEAW2tnYixXQtKxgGXq\n/3iSWG2bLwvxS4go3srO+aRXZHrFUMlJ5W0mCxl03aazxxKTsVVpZD8QZxvK91OQ\nh9zr9JBYqCLcCVbr8SkmYCi/laxIZxsNE5YI8cC8vvlLI7AMgSfPSnn/Epq1GjGY\n6L1iRcEDtanGCIvjqlCXO9+BmsnCfEVehqZkQHeYczA03tpOWb6pon2wzvMKSsKH\nks0ApVdstSLz1kzzAqem/uHdG9FyXdbTAwH1G4ZPv69sQAFAOCgAqYmdnzedsQtE\n1LQfaQrx0twO+CZJPcRLEESjq8ScQxWRRkfuh2VeR7cEU7L7KqT10mtUwrvw7APf\nDYoeCY9KyjIBjQXfbj2ke5u1hZj94Fsq9FfbEQg8ygCgwThnmkTrrKEiMSs3alYR\nORVCZpRuCPpmC8qmqxUnARDArzucjaclkxjLWvCVHeFa9UP7K3Nl9oTjJNv+7/jM\nWZs4eecIcUc4tKdHxcAJ0MO/Dkqq7hGaiHpwKY76wQ1+8xAh\n-----END CERTIFICATE-----\n".freeze]
  s.date = "2024-11-13"
  s.description = "    The interface library implements Java style interfaces for Ruby.\n    It lets you define a set a methods that must be defined in the\n    including class or module, or an error is raised.\n".freeze
  s.email = "djberg96@gmail.com".freeze
  s.extra_rdoc_files = ["README".freeze, "CHANGES".freeze, "MANIFEST".freeze]
  s.files = ["CHANGES".freeze, "MANIFEST".freeze, "README".freeze]
  s.homepage = "http://github.com/djberg96/interface".freeze
  s.licenses = ["Artistic-2.0".freeze]
  s.rubygems_version = "3.0.6".freeze
  s.summary = "Java style interfaces for Ruby".freeze

  s.installed_by_version = "3.5.16".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<test-unit>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
end
