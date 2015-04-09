module Runyoufools

class Test
	attr_reader :ok
	attr_reader :trials

	def initialize( testFile, retries, command )
		@file = testFile	
		@ok = nil
        @retries = retries
        @command = command
	end

	def run
		@trials = 0
		@retries.times do
			Runyoufools.log :info, "retrying #{@file}..." if @trials > 0
			@trials += 1
			_run
			return if @ok
		end
	end

	def _run
		Runyoufools.log :info, "RUNNING #{@file}"
        if @command
            toRun = "#{@command} #{@file}"
        else
            toRun = @file
        end
        @ok = system( toRun )
        if @ok == nil
            Runyoufools.log :error, "could not execute: #{toRun}"
        end
		Runyoufools.log :info,( "#{self}" )
	end

	def to_s
        result = { true => "OK   ".green.bold, false => "FAIL ".red.bold, nil => "ERROR".white.bold.on_red }[ @ok ]
		"#{result}: #{@trials} trial(s) : #{@file}"
	end
end

end
