class AddDraftOrderToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :draft_position, :integer, :null => false, :default => 1
  end
end
