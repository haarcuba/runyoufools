require 'fileutils'

module Runyoufools

class Runner
	attr_reader :results

	def initialize( options )
        @options = options
        @tests = []
        find_tests
		Runyoufools.log :info, "found #{@tests.count} tests:"
		@tests.each do |test| 
            puts test
        end
        exit( 0 ) if options.list
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

    def success
        @success == true
    end
end

end
