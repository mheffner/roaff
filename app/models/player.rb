class Player < ActiveRecord::Base
  belongs_to :pick

  def picked?
    !self.pick.nil?
  end

  def self.notpicked
    self.where("id NOT IN (SELECT DISTINCT(player_id) FROM picks)")
  end

  def name_and_position
    return "%s (%s)" % [name, position.upcase]
  end


end
