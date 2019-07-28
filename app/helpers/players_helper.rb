require 'player_positions'

module PlayersHelper
  def player_positions
    PlayerPositions::POSITIONS
  end
end
