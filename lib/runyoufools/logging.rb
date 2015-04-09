require 'logger'
require 'find'
require 'colorize'

module Runyoufools

    def self.colorize_level( text )
        text = text.sub( /info/, "INFO".white.bold )
        text = text.sub( /error/, "ERROR".white.bold.on_red )
        text = text.sub( /warn/, "WARN".yellow.bold )
    end

    def self.colorize_message( text )
        text = text.sub( /OK/, "OK".green.bold )
        text = text.sub( /FAIL/, "FAIL".red.bold )
    end

    module Logging
        @logger = Logger.new( 'runyoufools.log' )

        def self.logger
            @logger
        end
    end

    def self.log( level, message )
        puts "#{colorize_level( level.to_s.ljust(5) )}: #{colorize_message( message )}"
        method = Logging.logger.method level
        method.call message
    end

    def self.say( message )
        puts "#{colorize_message( message.to_s )}"
    end

    def self.say_list( list )
        list.each do |item|
            say( item )
        end
    end

end
