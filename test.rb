
#$LOAD_PATH.unshift('/home/morpheyesh/code/workspace/megam/gogs.rb/lib')
#require('gogs.rb')
require 'rubygems'
require 'megam_gogs'

class Test

def self.test(uname, pass)
 begin
  @test = Megam::GogsRepo.list(uname, pass)
  rescue ArgumentError => ae
      hash = {"msg" => ae.message, "msg_type" => "error"}
      re = Megam::Error.from_hash(hash)
      @res = {"data" => {:body => re}}
      return @res["data"][:body]
  end
 puts @test
 @test
end
end
test(morpheyesh, 1234567)
 
