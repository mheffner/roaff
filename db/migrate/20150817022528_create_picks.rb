class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :team_id, :null => false
      t.integer :player_id, :null => false
      t.integer :round, :null => false
      t.timestamps
    end

    add_index :picks, [:player_id], :unique => true
    add_index :picks, [:team_id, :round], :unique => true
  end
end
