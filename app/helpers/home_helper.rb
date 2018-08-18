module HomeHelper

  def total_teams
    if ENV['TOTAL_TEAMS']
      ENV['TOTAL_TEAMS'].to_i
    else
      8
    end
  end

  def row_size
    total_teams / 2
  end

  def team_grid_size
    12 / row_size
  end

  def team_row_offset
    (12 - (team_grid_size * row_size)) / 2
  end

  def team_klass(idx)
    klass = "col-md-#{team_grid_size}"

    if idx > 0 || team_row_offset == 0
      return klass
    end

    klass += " col-md-offset-#{team_row_offset}"
    return klass
  end

  def franchise_tag(round)
    if round == Pick::MAX_PICKS
      return "(FR)"
    else
      return ""
    end
  end
end
