require 'csv'

class AdminController < ApplicationController
  before_filter :authorize

  def index
    @teams = Team.all
    @avail_players = Player.notpicked.all

  end

  def drop_all_picks
    Pick.destroy_all

    Team.all.each do |t|
        t.updated!
    end

    redirect_to admin_path
  end

  def drop_all_players
    Player.destroy_all
    redirect_to admin_path
  end

  def upload_players
    ret = load_players(params[:players_csv])
    if !ret[0]
      redirect_to admin_path, :flash => {:error => "Error: #{ret[1]}"}
    else
      redirect_to admin_path, :flash => {:success => ret[1]}
    end
  end

  private

  def load_players(file)
    contents = file.read()

    csv = CSV.parse( contents,
                     { headers:           true,
                       converters:        :numeric,
                       header_converters: :symbol })

    players = []

    csv.each do |l|
      #puts "l #{l.inspect}"
      next if l[:rank].to_s == ""

      m = l[:pos].match(/\A([A-Z]+)([0-9]+)\Z/) rescue nil
      unless m
        return [false, "can't match #{l.inspect}"]
      end

      overall = l[:rank]
      position = defense(m[1])
      posrank = m[2]
      player = l[:overall]
      team = l[:team]
      bye = l[:bye]

      # Permit free agency
      if team == "FA"
        bye = nil
      else
        bye = Integer(bye)
      end

      # parse: player == Indianapolis (IND), team == ""
      if position == "DEF"
        m = player.match(/\A(.+) \((.+)\)\Z/) rescue nil
        if m
          player = m[1]
          team = m[2]
        end
      end

      p = Player.new(:name => player,
                     :position => position,
                     :team => team,
                     :bye_week => bye,
                     :total_rank => Integer(overall),
                     :positional_rank => Integer(posrank))
      players << p

      # arr = [overall,
      #        position,
      #        posrank,
      #        player,
      #        team,
      #        bye]
      # begin
      #   print_csv(arr)
      # rescue => e
      #   puts "unable to parse #{l.inspect} from #{arr.inspect}"
      #   puts "parsed as: #{e.inspect}"
      #   exit 1
      # end
    end

    players.each do |p|
      p.save
    end

    [true, "Imported #{players.length} players"]
  end

  def defense(str)
    str == "DST" ? "DEF" : str
  end

  # def load_players_old(file)
  #   contents = file.read()
  #   contents.split("\n").each do |line|
  #     line.chomp!
  #     csv = line.split(",")

  #     p = Player.new(:name => csv[3],
  #                    :position => csv[1] == "DST" ? "DEF" : csv[1],
  #                    :team => csv[4],
  #                    :bye_week => (csv[5] == "--") ? nil : Integer(csv[5]),
  #                    :total_rank => Integer(csv[0]),
  #                    :positional_rank => Integer(csv[2]))
  #     r = p.save
  #     return false unless r
  #   end
  # end

end
