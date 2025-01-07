# envbash

[![gem](https://img.shields.io/gem/v/envbash.svg?style=plastic)](https://rubygems.org/gems/envbash)
[![travis](https://img.shields.io/travis/scampersand/envbash-ruby/master.svg?style=plastic)](https://travis-ci.org/scampersand/envbash-ruby?branch=master)
[![codecov](https://img.shields.io/codecov/c/github/scampersand/envbash-ruby/master.svg?style=plastic)](https://codecov.io/gh/scampersand/envbash-ruby/branch/master)

Ruby gem for sourcing a bash script to augment the environment.

## Rationale

[12-factor apps](https://12factor.net/) require
[configuration loaded from the environment](https://12factor.net/config).

That's [easy on a platform like Heroku](https://devcenter.heroku.com/articles/config-vars),
where the environment is preset by the user with commands like
`heroku config:set`. But it's messier in development and non-Heroku
deployments, where the environment might need to be loaded from a file.

This package provides a mechanism for sourcing a Bash script to update
Ruby's environment (`ENV`). There are reasons for using a Bash script
instead of another configuration language:

1. Environment variable keys and values should always be strings. Using a Bash
   script to update the environment enforces that restriction, so there won't
   be surprises when you deploy into something like Heroku later on.

2. Using a script means that the values can be sourced into a Bash shell,
   something that's non-trivial if you use a different config language.

3. For better or worse, using a script means that environment variables can be
   set using the full power of the shell, including reading from other files.

Commonly the external file is called `env.bash`, hence the name of this project.

## Installation

Install from [RubyGems](https://rubygems.org/gems/envbash)

    gem install envbash

or in your Gemfile:

    gem 'envbash'

## Usage

Call `EnvBash.load` to source a Bash script into the current Ruby process.
Any variables that are set in the script, regardless of whether they are
explicitly exported, will be added to the process environment.

For example, given `env.bash` with the following content:

```bash
FOO='bar baz qux'
```

This can be loaded into Ruby:

```ruby
require 'envbash'

EnvBash.load('env.bash')

puts ENV['FOO']  #=> bar baz qux
```

## Legal

Copyright 2017 [Scampersand LLC](https://scampersand.com)

Released under the [MIT license](https://github.com/scampersand/envbash-ruby/blob/master/LICENSE)
