require "time"
require "uri"
require "zlib"
require 'openssl'
require 'net/http'
require 'excon'

__LIB_DIR__ = File.expand_path(File.join(File.dirname(__FILE__), ".."))
unless $LOAD_PATH.include?(__LIB_DIR__)
$LOAD_PATH.unshift(__LIB_DIR__)
end

require "megam/gogs/version"
require "megam/gogs/accounts"
require "megam/gogs/dumpout"
require "megam/gogs/errors"
require "megam/gogs/repos"
require "megam/core/gogs_client/gogs_repo"
require "megam/core/gogs_client/gogs_account"

module Megam
  class Gogs

    HEADERS = {
      'Accept' => 'application/json',
      'Accept-Encoding' => 'gzip',
      'User-Agent' => "megam-gogs/#{Megam::Gogs::VERSION}",
      'X-Ruby-Version' => RUBY_VERSION,
      'X-Ruby-Platform' => RUBY_PLATFORM

    }

    OPTIONS = {
      :headers => {},
      :host => 'localhost',
      :port => '3000',
      :nonblock => false,
      :scheme => 'http'
    }

    API_REST = "/api/v1"


    def text
      @text ||= Megam::Dumpout.new(STDOUT, STDERR, STDIN)
    end

    def last_response
      @last_response
    end

    # It is assumed that every API call will NOT use an API_KEY/email.
    def initialize(options={})
      @options = OPTIONS.merge(options)
      puts @options
      puts "checking header file"
    end
=begin
    def request(params, &block)
      start = Time.now
      @header = params[:headers]
      puts "PARAMS>........."
      text.msg "#{text.color("START", :cyan, :bold)}"
      #username =  params[:username] || ENV['MEGAM_GOGS_USERNAME']
      #password =  params[:password]  || ENV['MEGAM_GOGS_PASSWORD']
      #raise ArgumentError, "You must specify [:username, :password]" if username.nil? || password.nil?
      #text.msg "#{text.color("Got username[#{username}] [*******]", :red, :bold)}"

      begin
        httpcon = connection
        httpcon.use_ssl = false
        httpcon.start do |http|
          request = Net::HTTP::Get.new(@options[:path])
          {'key1' => @options[:headers]}
          puts request
        #request.basic_auth username, password
          @response = http.request(request)
           puts @response
          puts "DONEOENEONEONEONEONEONEOENONE"
      end
      end
      @response
    end
    private

    #Make a lazy connection.
    def connection
      @options[:path] =API_REST + @options[:path]
      @options[:headers] = @header

      #HEADERS.merge({
      #  'X-Megam-Date' =>  Time.now.strftime("%Y-%m-%d %H:%M")
      #}).merge(@options[:headers])

      text.info("HTTP Request Data:")
      text.msg("> HTTP #{@options[:scheme]}://#{@options[:host]}")
      @options.each do |key, value|
        text.msg("> #{key}: #{value}")
      end
      text.info("End HTTP Request Data.")
      http = Net::HTTP.new(@options[:host], @options[:port])
      http
    end

=end




def request(params,&block)
  #just_color_debug("#{@options[:path]}")
  start = Time.now
  text.msg "#{text.color("START", :cyan, :bold)}"
  params.each do |pkey, pvalue|
    text.msg("> #{pkey}: #{pvalue}")
  end
  @header = params[:headers]
  puts @header.class
  puts "------------------================="
    response = connection.request(params, &block)
    puts response
  text.msg("END(#{(Time.now - start).to_s}s)")
  # reset (non-persistent) connection
  @connection.reset
  response

end


#Make a lazy connection.
def connection
  @options[:path] =API_REST + @options[:path]
  @options[:headers] = @header

  #encoded_api_header = encode_header(@options)
  @options[:headers] = HEADERS.merge({
   "Authorization:" =>  @header
    }).merge(@options[:headers])
    puts @options[:headers]

    text.msg("HTTP Request Data:")
    text.msg("> HTTP #{@options[:scheme]}://#{@options[:host]}")
    @options.each do |key, value|
      text.msg("> #{key}: #{value}")
    end
    text.msg("End HTTP Request Data.")
    if @options[:scheme] == "https"
      @connection = Excon.new("#{@options[:scheme]}://#{@options[:host]}",@options)
    else
      Excon.defaults[:ssl_verify_peer] = false
      @connection = Excon.new("#{@options[:scheme]}://#{@options[:host]}:3000",@options)
    end
    @connection
  end
end
end
