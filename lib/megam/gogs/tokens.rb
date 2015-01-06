module Megam
  class Gogs

    def get_tokens(username=nil, password=nil)

      @options = {:path => "/users/#{username}/tokens",
        :body => '', :username => username, :password => password}.merge(@options)

        request(
        :expects  => 200,
        :method   => :get,
        :username => username,
        :password => password,
        :body     => @options[:body]
       )


      end

    end
  end
