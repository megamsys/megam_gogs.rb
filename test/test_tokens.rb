require File.expand_path("#{File.dirname(__FILE__)}/test_helper")
require 'nokogiri'

class TestGogs < MiniTest::Unit::TestCase
  def test_gettokens
    name = "morpheyesh"
    pass = "123456"
    response =megams.get_tokens(name, pass)


  end

end
