require File.expand_path("#{File.dirname(__FILE__)}/test_helper")
require 'nokogiri'

class TestGogs < MiniTest::Unit::TestCase
  def test_getrepos
  token = '4760a3130da97bf258d8be4d55ac8165ba7a3e55'
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
