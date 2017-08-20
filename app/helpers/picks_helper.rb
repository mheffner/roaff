module PicksHelper
  def default_selected_team
    @pick.team_id || nil
  end

  def default_selected_player
    @pick.player_id || nil
  end

  def class_for_picks_form
    base = "new_pick"

    if @admin
      return base
    else
      return base + " pick_dynamic"
    end
  end
end
