#!/usr/bin/ruby
Dir.foreach(ARGV[0]) do |f|
  if f.include? "bread"
   puts f
  end
end
