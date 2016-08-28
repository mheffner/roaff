class AdminController < ApplicationController
  before_filter :authorize

  def index
    @teams = Team.all
    @avail_players = Player.notpicked.all

  end

  def drop_all_picks
    Pick.destroy_all
    redirect_to admin_path
  end

  def drop_all_players
    Player.destroy_all
    redirect_to admin_path
  end

  def upload_players
    puts "upload params: #{params.inspect}"

    ret = load_players(params[:players_csv])
    if !ret
      redirect_to admin_path, :flash => {:error => "Unable to load players"}
    else
      redirect_to admin_path, :flash => {:success => "Worked"}
    end
  end

  private

  def load_players(filename)
    File.open(filename).each do |line|
      line.chomp!
      csv = line.split(",")

      p = Player.new(:name => csv[3],
                     :position => csv[1] == "DST" ? "DEF" : csv[1],
                     :team => csv[4],
                     :bye_week => (csv[5] == "--") ? nil : Integer(csv[5]),
                     :total_rank => Integer(csv[0]),
                     :positional_rank => Integer(csv[2]))
      r = p.save
      return false unless r
    end
  end

end
