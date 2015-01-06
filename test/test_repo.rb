require File.expand_path("#{File.dirname(__FILE__)}/test_helper")
require 'nokogiri'

class TestGogs < MiniTest::Unit::TestCase
  def test_getrepos

    #response =megams.get_repos(name, pass)
    assert_raises(ArgumentError)
     puts response
     puts "tadadada"
  end
=begin
  def test_getrepos_error

    response =megams.get_repos("abcd", "abcd")
    assert_raises(ArgumentError)
  end
=end
end
