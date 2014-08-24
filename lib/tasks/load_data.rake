namespace :data do
  desc "Load player data"
  task :load_players => :environment do
    File.open("players.csv").each do |line|
      line.chomp!
      csv = line.split(",")

      p = Player.new(:name => csv[3],
                     :position => csv[1],
                     :team => csv[4],
                     :bye_week => (csv[5] == "--") ? nil : Integer(csv[5]),
                     :total_rank => Integer(csv[0]),
                     :positional_rank => Integer(csv[2]),
                     :picked => 0)
      #puts "p: #{p.inspect}"
      exit 1 unless p.save
    end
  end

  desc "Drop all player data"
  task :drop_players => :environment do
    Player.destroy_all
  end
end
