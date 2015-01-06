require File.expand_path("#{File.dirname(__FILE__)}/../lib/megam/gogs")

require 'rubygems'
gem 'minitest' # ensure we are using the gem version
require 'minitest/autorun'
require 'time'

SANDBOX_HOST_OPTIONS = {
  :host => 'localhost',
  :port => 3000
}


def megam(options)
  options = SANDBOX_HOST_OPTIONS.merge(options)
  mg=Megam::Gogs.new(options)
end

def megams(options={})
  s_options = SANDBOX_HOST_OPTIONS.merge(options)
  #options = s_options.merge(options)
  mg=Megam::Gogs.new(s_options)
end

def sandbox_json
  {:json =>
    '{"name":"Simpson", "displayName":"test", "mail":"homersimpson@springfield.com", "password":"bart"}'
  }
end
