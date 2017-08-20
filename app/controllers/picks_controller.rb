class PicksController < ApplicationController
  before_filter :authorize

  def index
    @picks = Pick.unscoped.order(:id).reverse_order.all
  end

  def destroy
    @pick = Pick.find(params[:id])
    @pick.destroy
    @pick.team.updated!
    redirect_to picks_path
  end

  def new
    @admin = params[:admin]
    @teams = Team.all
    @pick = Pick.new
    @avail_players = Player.notpicked.all

    if @admin && cookies[:saved_team_id]
      team = Team.find(cookies[:saved_team_id]) rescue nil
      if team
        @pick.team = team
      end
    end

    if @admin && cookies[:saved_player_id]
      player = Player.notpicked.find(cookies[:saved_player_id]) rescue nil
      if player
        @pick.player = player
      end
    end
  end

  def create
    team = Team.find(params[:team_id])
    do_404 unless team

    player = Player.find(params[:player_id])
    do_404 unless player

    if player.picked?
      redirect_to new_pick_path, :flash => {:error => "Player already picked"}
      return
    end

    cookies[:saved_player_id] = player.id

    round = Integer(params.delete(:round))
    puts "checking if team has round '#{round}'"
    if team.has_round?(round)
      redirect_to new_pick_path, :flash => {:error => "Team #{team.name} already has round #{round} pick"}
      return
    end


    pick = Pick.new(:team_id => team.id, :player_id => player.id, :round => round)
    if pick.save
      cookies[:saved_team_id] = team.id
      cookies[:saved_player_id] = nil

      # Force update
      team.updated!

      redirect_to new_pick_path, :flash => {:success => "Picked #{pick.player.name_and_position} in the #{pick.round} round for #{pick.team.name}"}
    else
      redirect_to new_pick_path, :flash => {:error => "unable to save"}
    end

  end

end
