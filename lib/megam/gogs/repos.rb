module Megam
 class Gogs

    #Yet to be tested

    def get_repos(token=nil)



      @options = {:path => "/user/repos",
        :body => ''}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :token => token,
        :body => @options[:body]

      )
    end

end
end
