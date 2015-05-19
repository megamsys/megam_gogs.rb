require 'time'
require 'uri'
require 'zlib'
require 'openssl'
require 'net/http'
require 'excon'
require 'base64'
require 'yaml'

__LIB_DIR__ = File.expand_path(File.join(File.dirname(__FILE__), '..'))
$LOAD_PATH.unshift(__LIB_DIR__) unless $LOAD_PATH.include?(__LIB_DIR__)

require 'megam/gogs/version'
require 'megam/gogs/accounts'
require 'megam/gogs/dumpout'
require 'megam/gogs/errors'
require 'megam/gogs/repos'
require 'megam/gogs/tokens'

require 'megam/core/gogs_repo'
require 'megam/core/gogs_account'
require 'megam/core/gogs_tokens'

module Megam
  class Gogs
    AUTH_PREFIX = 'Authorization'
    HEADERS = {
      'Accept' => 'application/json',
      'Accept-Encoding' => 'gzip',
      'User-Agent' => "megam-gogs/#{Megam::Gogs::VERSION}",
      'X-Ruby-Version' => RUBY_VERSION,
      'X-Ruby-Platform' => RUBY_PLATFORM
    }

    OPTIONS = {
      headers: {},
      host: "localhost",
      port: "6001",
      nonblock: false,
      scheme: 'http'
    }

    API_REST = '/api/v1'

    def text
      @text ||= Megam::Dumpout.new(STDOUT, STDERR, STDIN)
    end

    attr_reader :last_response

    # It is assumed that every API call will NOT use an API_KEY/email.
    def initialize(options = {})
      @options = OPTIONS.merge(options)
    end

    def request(params, &block)
      start = Time.now

      dummy_params =  {
        expects: params[:expects],
        method: params[:method],
        body: params[:body]
      }

      text.msg "#{text.color('START', :cyan, :bold)}"
      params.each do |pkey, pvalue|
        text.msg("> #{pkey}: #{pvalue}")
      end

      if params[:token].nil?
        @uname = params[:username]
        @pass = params[:password]
        @cred = "#{@uname}:#{@pass}"
        @final_cred64 = Base64.encode64(@cred)

        @final_hash = { creds: "Basic #{@final_cred64}" }

        response = connection_repo.request(dummy_params, &block)
        text.msg("END(#{(Time.now - start)}s)")
      else

        @tokens = params[:token]
        @final_token = { token: "token #{@tokens}" }
        response = connection_token.request(dummy_params, &block)

        puts response.inspect
        text.msg("END(#{(Time.now - start)}s)")
        # reset (non-persistent) connection
        # @connection_token.reset
      end

      response
    end

    private

    # Make a lazy connection.
    def connection_repo
      @options[:path] = API_REST + @options[:path]

      @options[:headers] = HEADERS.merge(AUTH_PREFIX => @final_hash[:creds]).merge(@options[:headers])

      text.msg('HTTP Request Data:')
      text.msg("> HTTP #{@options[:scheme]}://#{@options[:host]}")
      @options.each do |key, value|
        text.msg("> #{key}: #{value}")
      end
      text.msg('End HTTP Request Data.')
      if @options[:scheme] == 'https'
        @connection = Excon.new("#{@options[:scheme]}://#{@options[:host]}", @options)
      else
        Excon.defaults[:ssl_verify_peer] = false
        @connection = Excon.new("#{@options[:scheme]}://#{@options[:host]}:6001", @options)
      end
      @connection
      end

    def connection_token
      @options[:path] = API_REST + @options[:path]
      @options[:headers] = HEADERS.merge(AUTH_PREFIX => @final_token[:token]).merge(@options[:headers])
      text.msg('HTTP Request Data:')
      text.msg("> HTTP #{@options[:scheme]}://#{@options[:host]}")
      @options.each do |key, value|
        text.msg("> #{key}: #{value}")
      end
      text.msg('End HTTP Request Data.')
      if @options[:scheme] == 'https'
        @connection = Excon.new("#{@options[:scheme]}://#{@options[:host]}", @options)
      else
        Excon.defaults[:ssl_verify_peer] = false
        @connection = Excon.new("#{@options[:scheme]}://#{@options[:host]}:6001", @options)
      end
      @connection
      end
  end
end
