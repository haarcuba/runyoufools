require 'fileutils'
require 'logger'
require 'colorize'

$logger = Logger.new( 'whiterabbit.log' )

def colorize( text )
    text.sub( /OK/, "OK".green.bold )
    text.sub( /FAIL/, "FAIL".red.bold )
    text.sub( /ERROR/, "ERROR".red.bold )
    text.sub( /RUNNING/, "RUNNING".white.bold )
end

def log( message )
	puts colorize( message )
	$logger.info message
end

class Test
	attr_reader :ok
	attr_reader :trials

	def initialize( testFile )
		@file = testFile	
		@ok = nil
		if ENV[ 'RETRIES' ]
			@retries = ENV[ 'RETRIES' ].to_i
		else
			@retries = 1
		end
	end

	def run
		@trials = 0
		@retries.times do
			@trials += 1
			_run
			return if @ok
			log "retrying #{@file}..."
		end
	end

	def _run
		command = @file
		log "RUNNING #{@file}"
		@ok = system( command )
		log( "#{self}" )
	end

	def to_s
        result = { true => "OK  ".green.bold, false => "FAIL".red.bold }[ @ok ]
		"#{result}: #{@trials} trial(s) : #{@file}"
	end
end

class Runner
	attr_reader :results
	attr_reader :success

	def initialize( tests )
		@tests = ARGV
		if @tests.size == 0
			@tests = Dir.glob( 'examples/*test*' )
		end
		puts "found #{@tests.count} tests:"
		puts @tests
		@results = { fail: [], pass: [] }
	end

	def go
        log "white rabiit run starting"
		@success = true
		@tests.each do |testFile|
			test = Test.new( testFile )
			test.run
			key = test.ok ? :pass : :fail
			@results[ key ].push( test )
			@success = @success && test.ok
		end
	end

	def message
		{ true => 'OK', false => 'FAIL' }[ @success ]
	end
end
