require_relative 'helper'
require 'envbash'


class TestLoad < Minitest::Test
  def setup
    @orig = ENV.to_h
    ENV['A'] = 'A'
    ENV['B'] = 'B'
    ENV['C'] = 'C'
    ENV.delete('D')
    @loaded = ENV.to_h.merge('A'=>'a', 'D'=>'d')
    @loaded.delete('B')
  end

  def teardown
    ENV.replace(@orig)
  end

  def test_load_no_override_no_remove
    EnvBash.stub :read, @loaded do
      # the first argument doesn't matter since read is stubbed
      EnvBash.load('')
    end
    assert_equal ENV['A'], 'A'  # NOT overridden
    assert_equal ENV['B'], 'B'  # NOT removed
    assert_equal ENV['C'], 'C'  # inherited
    assert_equal ENV['D'], 'd'  # loaded
  end

  def test_load_override_no_remove
    EnvBash.stub :read, @loaded do
      # the first argument doesn't matter since read is stubbed
      EnvBash.load('', override: true)
    end
    assert_equal ENV['A'], 'a'  # overridden
    assert_equal ENV['B'], 'B'  # NOT removed
    assert_equal ENV['C'], 'C'  # inherited
    assert_equal ENV['D'], 'd'  # loaded
  end

  def test_load_no_override_remove
    EnvBash.stub :read, @loaded do
      # the first argument doesn't matter since read is stubbed
      EnvBash.load('', remove: true)
    end
    assert_equal ENV['A'], 'A'  # NOT overridden
    assert ! ENV.include?('B')  # removed
    assert_equal ENV['C'], 'C'  # inherited
    assert_equal ENV['D'], 'd'  # loaded
  end

  def test_load_override_remove
    EnvBash.stub :read, @loaded do
      # the first argument doesn't matter since read is stubbed
      EnvBash.load('', override: true, remove: true)
    end
    assert_equal ENV['A'], 'a'  # overridden
    assert ! ENV.include?('B')  # removed
    assert_equal ENV['C'], 'C'  # inherited
    assert_equal ENV['D'], 'd'  # loaded
  end

  def test_load_into
    orig = ENV.to_h
    into = {}
    EnvBash.stub :read, {'A'=>'B'} do
      # the first argument doesn't matter since read is stubbed
      EnvBash.load('', into: into)
    end
    assert_equal into, {'A'=>'B'}
    assert_equal ENV.to_h, orig
  end
end
