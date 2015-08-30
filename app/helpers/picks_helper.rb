module PicksHelper
  def default_selected_team
    @pick.team_id || nil
  end

  def default_selected_player
    @pick.player_id || nil
  end
end
