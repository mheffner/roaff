#!/usr/bin/ruby

exit 2 if ARGV.length != 1

file = ARGV[0]
File.open(file).each do |line|
  line.chomp!.chomp!("\n")

  #r = line.match(/([0-9]{1,}\. \([0-9]{1,}\))/)
  #puts "matched: #{line} to #{r.inspect}"
  #break
  line.gsub!(/([0-9]{1,}\. \([A-Z]{1,}[0-9]{1,}\))/, "\n" + '\1')

  print line
end
