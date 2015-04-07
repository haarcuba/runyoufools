class Test
	attr_reader :ok
	attr_reader :trials

	def initialize( testFile, retries )
		@file = testFile	
		@ok = nil
        @retries = retries
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
		command = @file
		log :info, "RUNNING #{@file}"
		@ok = system( command )
		log :info,( "#{self}" )
	end

	def to_s
        result = { true => "OK  ".green.bold, false => "FAIL".red.bold }[ @ok ]
		"#{result}: #{@trials} trial(s) : #{@file}"
	end
end
