class Player < ActiveRecord::Base

  def self.notpicked
    where(:picked => 0)
  end

  def picked?
    picked == 1
  end

  def setPicked(b)
    self.picked = b ? 1 : 0
  end
end
