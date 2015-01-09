require File.expand_path("#{File.dirname(__FILE__)}/test_helper")
require 'nokogiri'

class TestGogs < MiniTest::Unit::TestCase
  def test_getrepos
  token = 'f39f10eda64a14fe23a3ff2ad2afdb480162d379'
    response =megams.get_repos(token)
    assert_raises(ArgumentError)
      end
=begin
  def test_getrepos_error

    response =megams.get_repos("abcd", "abcd")
    assert_raises(ArgumentError)
  end
=end
end
