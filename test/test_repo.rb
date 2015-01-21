require File.expand_path("#{File.dirname(__FILE__)}/test_helper")
require 'nokogiri'

class TestGogs < MiniTest::Unit::TestCase
  def test_getrepos
  token = 'bb229aba7cea113875834c84d339ec9928666643'
    response =megams.get_repos(token)
   
      end
=begin
  def test_getrepos_error

    response =megams.get_repos("abcd", "abcd")
    assert_raises(ArgumentError)
  end
=end
end
