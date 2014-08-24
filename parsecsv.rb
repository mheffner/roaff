#!/usr/bin/env ruby

File.open("rawcsv.csv").each do |line|
  line.chomp!
  csv = line.split(",")
  # if csv.length == 7
  #   csv2 = [csv[0], csv[1], csv[2], "#{csv[3]} #{csv[4]}", csv[5], csv[6]]
  #   csv = csv2
  # end

  next if csv.length == 0

  if csv.length != 5
    puts csv.inspect
    exit 1
  end

 # puts csv.inspect
  posre = /([A-Z]+)([0-9]+)/
  posm = csv[4].match(posre)
#  puts "posm #{posm.inspect}"
  exit 1 unless posm

  out = [csv[0].to_i,
         posm[1],
         posm[2],
         csv[1],
         csv[2],
         csv[3]]

  #puts "in: #{csv.inspect}"
  #puts "out: #{out.inspect}"
  puts out.join(",")
end
