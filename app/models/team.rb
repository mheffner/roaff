class Team < ActiveRecord::Base
  default_scope {order('draft_position ASC')}

  has_many :picks

  def has_round?(round)
    picks.where(:round => round).count > 0
  end

end
