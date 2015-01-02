module Megam
  class Gogs
    # GET /accounts
    #Yet to be tested
    require 'base64'

    def get_repos(username=nil, password=nil)

     string = '#{username}:#{password}'

     creds = Base64.encode64(string)
     get_tokens(creds)


      @options = {:path => "/",
        :body => ''}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :username => username,
        :password => password,
        :body     => @options[:body]
        :headers  =>
      )
    end

def get_tokens(c)
  @options = {:path => "/",
    :body => ''}.merge(@options)

    request(
    :expects  => 200,
    :method   => :get,
    :username => username,
    :password => password,
    :body     => @options[:body]
    :headers  =>
    )


  end
end
