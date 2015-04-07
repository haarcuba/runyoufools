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
			log :info, "retrying #{@file}..." if @trials > 0
			@trials += 1
			_run
			return if @ok
		end
	end

	def _run
		log :info, "RUNNING #{@file}"
        if @command
            @ok = system( "#{@command} #{@file}" )
        else
            @ok = system( @file )
        end
		log :info,( "#{self}" )
	end

	def to_s
        result = { true => "OK  ".green.bold, false => "FAIL".red.bold }[ @ok ]
		"#{result}: #{@trials} trial(s) : #{@file}"
	end
end
