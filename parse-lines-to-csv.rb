#!/usr/bin/env ruby
def defense(str)
  str == "D/ST" ? "DEF" : str
end

exit 2 unless ARGV.length == 1

file = ARGV[0]

File.open(file).each do |line|
  line.chomp!
  csv = line.split(" ")
  #puts csv.inspect

  overall = csv.shift.gsub(/\./, "")
  m = csv.shift.match(/\(([A-Z]{1,})([0-9]{1,})\)/)
  unless m
    puts "line: #{line.inspect}"
    exit 3
  end
  position = m[1]
  posrank = m[2]
  bye = csv.pop
  team = csv.pop

  #puts "line: #{line}"
  #puts "%s,%s,%s,%s,%s:%s" % [overall, position, posrank, bye, team, csv.join(" ")]
  #exit 3

  puts [overall,
   position,
   posrank,
   csv.join(" "),
   team,
   bye].join(",")

end
