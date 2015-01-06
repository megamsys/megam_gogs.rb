module Megam
  class Gogs

    #Yet to be tested
    require 'base64'

    def get_repos(username=nil, password=nil)

     string = "#{username}:#{password}"
     puts string
     creds = Base64.encode64(string)
     puts "Printing creds"
     puts creds
     get_tokens(creds, username)


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

def get_tokens(c,u)
  cred = " Basic #{c}"
  @options = {:path => "/users/#{u}/tokens",
    :body => ''}.merge(@options)
    puts "Printing cred"
    puts cred
    puts "-----"

    request(
    :expects  => 200,
    :method   => :get,
    :body     => @options[:body],
    :headers  => cred
    )
   puts @response

  end

end
end
