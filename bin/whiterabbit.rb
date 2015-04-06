require 'lib/runner.rb'

runner = Runner.new( ARGV )
start = Time.now
runner.go
durationMinutes = "%.2f" % ( ( Time.now - start ) / 60 )
puts "TESTS OVER - SUMMARY".white.bold
puts "pass:"
puts runner.results[ :pass ]
puts "fail:"
puts runner.results[ :fail ]
puts colorize( runner.message )
puts "#{durationMinutes} minutes."

log "Story Test run finished (#{durationMinutes} minutes): #{runner.success}"
exit( runner.success )
