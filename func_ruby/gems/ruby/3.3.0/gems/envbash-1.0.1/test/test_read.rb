require_relative 'helper'
require 'fileutils'
require 'tmpdir'
require 'envbash'


class TestRead < Minitest::Test
  def setup
    @tmpdir = Dir.mktmpdir
    @envbash = File.join @tmpdir, 'env.bash'
    @orig = ENV.to_h
  end

  def teardown
    ENV.replace(@orig)
    FileUtils.rm_rf(@tmpdir)
  end

  def test_read_missing_not_ok
    assert_error_raised(nil, Errno::ENOENT) do
      EnvBash.read @envbash
    end
  end

  def test_read_missing_ok
    assert_no_error do
      EnvBash.read @envbash, missing_ok: true
    end
  end

  def test_read_permission_error
    FileUtils.chmod 0, @tmpdir
    assert_error_raised(nil, Errno::EACCES) do
      EnvBash.read @envbash
    end
  end

  def test_read_empty
    FileUtils.touch @envbash
    result = EnvBash.read @envbash
    assert_equal result, @orig
  end

  def test_read_normal
    ENV.delete('FOO')
    orig = ENV.to_h  # separate from @orig
    File.open(@envbash, 'w') do |f|
      f.write 'FOO=BAR'
    end
    result = EnvBash.read @envbash
    assert_equal result['FOO'], 'BAR'
    result.delete('FOO')
    assert_equal result, orig
  end

  def test_read_error
    File.open(@envbash, 'w') do |f|
      # stderr doesn't matter, nor does final status.
      f.write "echo 'okay!' >&2\nfalse"
    end
    result = EnvBash.read @envbash
    assert_equal result, @orig
  end

  def test_read_exit
    File.open(@envbash, 'w') do |f|
      f.write 'exit'
    end
    assert_error_raised(nil, EnvBash::ScriptExitedEarly) do
      EnvBash.read @envbash
    end
  end

  def test_read_env
    File.open(@envbash, 'w') do |f|
      f.write 'FOO=BAR'
    end
    result = EnvBash.read @envbash, env: {}
    assert_equal result, {'FOO'=>'BAR'}
  end

  def test_read_fixups
    File.open(@envbash, 'w') do |f|
      f.write 'A=B; C=D; E=F; G=H'
    end
    myenv = {'A'=>'Z', 'E'=>'F'}
    result = EnvBash.read @envbash, env: myenv, fixups: ['A', 'C']
    # there will be extra stuff in result since fixups is overridden, so can't
    # test strict equality.
    assert_equal result['A'], 'Z'  # fixups, myenv, env.bash
    assert !result.include?('C')   # fixups, not myenv, env.bash
    assert_equal result['E'], 'F'  # not fixups, myenv, env.bash
    assert_equal result['G'], 'H'  # not fixups, not myenv, env.bash
  end
end
