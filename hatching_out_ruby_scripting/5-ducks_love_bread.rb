#!/usr/bin/ruby
Dir.foreach(ARGV[0])
puts Dir.glob("*bread*")
