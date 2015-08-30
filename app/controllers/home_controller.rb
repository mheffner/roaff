class HomeController < ApplicationController
  MAX = 10

  before_filter :authorize

  layout "nocontainer", except: [:index]

  def overview
    @playergroups = build_player_groups(MAX, false)
  end

  def team_overview
    @teams = Team.all
    @last_pick = Pick.unscoped.last
  end

  def admin
    @show_pick = true
    @playergroups = build_player_groups(nil, true)
  end

  def index
  end

  private

  def positions
    [
     {:name => "Running Backs", :code => "RB"},
     {:name => "Quarterbacks", :code => "QB"},
     {:name => "Wide Receivers", :code => "WR"},
     {:name => "Tight Ends", :code => "TE"},
     {:name => "Kickers", :code => "K"},
     {:name => "Defense", :code => "DEF"},
    ]
  end

  def build_player_groups(limit, all)
    playergroups = []

    positions.each do |p|
      gr = {:name => p[:name],
        :code => p[:code],
        :players => find_players(p[:code], limit, all)
      }
      playergroups << gr
    end
    playergroups
  end

  def find_players(pos, limit, all)
    if all
      dset = Player.where(:position => pos).order(:total_rank)
    else
      dset = Player.notpicked.where(:position => pos).order(:total_rank)
    end

    if (limit)
      dset = dset.limit(limit)
    end

    dset.all
  end
end
