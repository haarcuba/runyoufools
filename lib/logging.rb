require 'logger'
require 'find'
require 'colorize'

def colorize_level( text )
    text = text.sub( /info/, "INFO".white.bold )
    text = text.sub( /error/, "ERROR".red.bold )
    text = text.sub( /warn/, "WARN".yellow.bold )
end

def colorize_message( text )
    text = text.sub( /OK/, "OK".green.bold )
    text = text.sub( /FAIL/, "FAIL".red.bold )
end

module Logging
    @logger = Logger.new( 'runyoufools.log' )

    def self.logger
        @logger
    end
end

def log( level, message )
	puts "#{colorize_level( level.to_s.ljust(5) )}: #{colorize_message( message )}"
    method = Logging.logger.method level
	method.call message
end

def say( message )
	puts "#{colorize_message( message.to_s )}"
end

def say_list( list )
    list.each do |item|
        say( item )
    end
end

