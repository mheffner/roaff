#!/usr/bin/env ruby
def defense(str)
  str == "D/ST" ? "DEF" : str
end

File.open("raw2014.txt").each do |line|
  line.chomp!
  csv = line.split(" ")
  #puts csv.inspect


  if csv.length == 8
#    puts "csv.inspect: #{csv.inspect}"
    puts "#{csv[0]},#{csv[1]} #{csv[2]} #{csv[3].chomp(",")},#{defense(csv[4])},#{csv[5]},#{csv[6]}"
  else
#    puts "csv.inspect: #{csv.inspect}"
    puts "#{csv[0]},#{csv[1]} #{csv[2].chomp(",")},#{defense(csv[3])},#{csv[4]},#{csv[5]}"
  end
end
