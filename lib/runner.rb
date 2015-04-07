require 'fileutils'
require 'lib/logging'
require 'pp'
require 'lib/test'

class Runner
	attr_reader :results
	attr_reader :success

	def initialize( options )
        log :info, "WHITE RABBIT starting"
        @options = options
        @tests = []
        find_tests
		log :info, "found #{@tests.count} tests:"
		PP.pp @tests
		@results = { fail: [], pass: [] }
	end

    def find_tests
        Find.find('.') do |path|
            if @options.pattern.match( path )
                if File.file?( path )
                    @tests.push( path )
                end
            end
        end
    end

	def go
		@success = true
		@tests.each do |testFile|
			test = Test.new( testFile, @options.retries, @options.command )
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
