#module Megam
#  class Gogs

    #Yet to be tested
    require 'base64'

    def get_repos(username=nil, password=nil)



      @options = {:path => "/",
        :body => ''}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :username => username,
        :password => password,
        :body     => @options[:body]

      )
    end

#end
#end
