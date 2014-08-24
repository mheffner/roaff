class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name, :null => false
      t.string :position, :null => false
      t.string :team

      t.integer :total_rank, :null => false
      t.integer :positional_rank, :null => false

      t.integer :bye_week

      t.integer :picked

      t.timestamps
    end
  end
end
