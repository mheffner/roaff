#!/usr/bin/ruby

# from: http://www.espn.com/fantasy/football/story/_/id/16287927/2016-fantasy-football-rankings-fantasy-football-player-rankings-top-fantasy-football-players-fantasy-football-draft

require 'rubygems'
require 'hpricot'


exit 2 if ARGV.length != 1

file = ARGV[0]

doc = open(file) { |f| Hpricot(f) }

(doc/"tbody/tr").each do |row|
  #puts "row: #{row.inspect}"

  tds = (row/"td").collect {|t| t}

  #puts "tds: #{tds.inspect}"

  rank = tds[0].inner_html.match(/[0-9]+/)[0]
  pos = tds[1].inner_html
  team = tds[2].inner_html
  bye = tds[3].inner_html
  posrank = tds[4].inner_html
  posranknum = posrank.match(/[A-Z]+([0-9]+)/)[1]

  player = (tds[0]/"a").inner_html
  if player == nil || player == ""
    player = tds[0].inner_html.match(/[0-9]+\. (.+)$/)[1]
    #puts "got rank: #{rank}, player: '#{player}', bailing on '#{tds[0].inner_html}'"
    #exit 1
  end


  #puts "rank: #{rank}, player: '#{player}', pos: #{pos}, team: #{team}, bye: #{bye}, posrank: #{posrank}, posranknum: #{posranknum}"

  fields = [Integer(rank), pos, Integer(posranknum), player, team, bye]
  puts fields.join(",")
end
