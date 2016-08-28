class AddIndexToPlayersOnPosition < ActiveRecord::Migration
  def change
    add_index :players, [:position]
  end
end
