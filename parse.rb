#!/usr/bin/env ruby

File.open("ppr300.txt").each do |line|
  line.split(" ").each do |wrd|
    next if wrd.length == 0
    wrd.chomp!(",")
    if wrd =~ /[0-9]+\./
      puts "\n"
    end
    print "#{wrd},"
  end
end
