#!/usr/bin/env ruby

require 'csv'

def defense(str)
  str == "DST" ? "DEF" : str
end

def print_csv(arr)
  arr.each do |f|
    if f.nil? ||
      ((f.is_a?(String) && f.length == 0) && arr[1] != "DEF")
      raise "invalid #{arr.inspect}"
    end
  end

  puts arr.join(",")
end


exit 2 unless ARGV.length == 1

file = ARGV[0]

csv = CSV.table(file)

csv.each do |l|
  #puts "l #{l.inspect}"
  next if l[:rank].to_s == ""

  m = l[:pos].match(/\A([A-Z]+)([0-9]+)\Z/) rescue nil
  unless m
    puts "can't match #{l.inspect}"
    exit 2
  end

  overall = l[:rank]
  position = defense(m[1])
  posrank = m[2]
  player = l[:overall]
  team = l[:team]
  bye = l[:bye]

  next if team == "FA"

  # parse: player == Indianapolis (IND), team == ""
  if position == "DEF"
    m = player.match(/\A(.+) \((.+)\)\Z/) rescue nil
    if m
      player = m[1]
      team = m[2]
    end
  end

  arr = [overall,
         position,
         posrank,
         player,
         team,
         bye]
  begin
    print_csv(arr)
  rescue => e
    puts "unable to parse #{l.inspect} from #{arr.inspect}"
    puts "parsed as: #{e.inspect}"
    exit 1
  end
end
