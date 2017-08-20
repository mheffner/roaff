class Team < ActiveRecord::Base
  default_scope {order('draft_position ASC')}

  has_many :picks

  def has_round?(round)
    picks.where(:round => round).count > 0
  end

  def updated!
    self.update!(:updated_at => Time.now)
  end

  def rounds_left
    myrounds = self.picks.map(&:round)

    1.upto(Pick::MAX_PICKS).map{|i| i} - myrounds
  end
end
