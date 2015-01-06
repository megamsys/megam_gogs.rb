module Megam
  class Dumpout

    attr_reader :stdout
    attr_reader :stderr
    attr_reader :stdin
    
    def initialize(stdout, stderr, stdin)
      @stdout, @stderr, @stdin = stdout, stderr, stdin
    end

    def highline
      @highline ||= begin
      require 'highline'
      HighLine.new
      end
    end

    
    def msg(message)
      stdout.puts message
    end

    # Prints a message to stdout. Aliased as +info+ for compatibility with
    # the logger API.

    def info(message)
      stdout.puts("#{color('INFO:', :green, :bold)} #{message}")
    end

    # Prints a msg to stderr. Used for warn, error, and fatal.
    def err(message)
      stderr.puts message
    end

    # Print a warning message
    def warn(message)
      err("#{color('WARNING:', :yellow, :bold)} #{message}")
    end

    # Print an error message
    def error(message)
      err("#{color('ERROR:', :red, :bold)} #{message}")
    end

    # Print a message describing a fatal error.
    def fatal(message)
      err("#{color('FATAL:', :red, :bold)} #{message}")
    end

    def color(string, *colors)
      if color?
        highline.color(string, *colors)
      else
      string
      end
    end

    # Should colored output be used ?. When output is not to a
    # terminal, colored output is never used
    def color?
      stdout.tty?
    end

    def list(*args)
      highline.list(*args)
    end

    def pretty_print(data)
      stdout.puts data
    end

  end
end