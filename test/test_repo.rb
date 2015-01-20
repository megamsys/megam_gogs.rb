require File.expand_path("#{File.dirname(__FILE__)}/test_helper")
require 'nokogiri'

class TestGogs < MiniTest::Unit::TestCase
  def test_getrepos
  token = 'd8e603d19b2e6e1c167518fdc086d3db50ef33af'
    response =megams.get_repos(token)
   
      end
=begin
  def test_getrepos_error

    response =megams.get_repos("abcd", "abcd")
    assert_raises(ArgumentError)
  end
=end
end
