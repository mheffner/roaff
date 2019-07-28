class PlayersController < ApplicationController
  before_filter :authorize

  def update
    p = Player.find(params[:id])
    not_found and return unless p
    return "{}"
  end

  def new
    @next_total_rank = last_total_rank + 1
    @player = Player.new
  end

  def create
    @next_total_rank = last_total_rank + 1
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to new_player_path, notice: 'Player was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def player_params
    params[:player].permit(:name, :position, :team, :total_rank, :positional_rank, :bye_week)
  end

  # XXX
  def not_found
    render :nothing => true, :status => 400
  end

  def last_total_rank
    begin
      p = Player.order(:total_rank).reverse_order.first
      p.total_rank
    rescue
      0
    end
  end
end
