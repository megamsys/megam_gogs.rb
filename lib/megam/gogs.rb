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
require "megam/gogs/tokens"
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
    end

def request(params,&block)
  #just_color_debug("#{@options[:path]}")
  start = Time.now
  text.msg "#{text.color("START", :cyan, :bold)}"
  params.each do |pkey, pvalue|
    text.msg("> #{pkey}: #{pvalue}")
  end
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
  encoded_api_header = encode_header(@options)
  @options[:headers] = HEADERS.merge({}).merge(@options[:headers])
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


  def encode_header(cmd_parms)
    header_params ={}
    body_digest = ()

    body_base64 = Base64.encode64(body_digest)

  end




end
end
