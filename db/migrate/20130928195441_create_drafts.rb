class CreateDrafts < ActiveRecord::Migration
  def change
    create_table :drafts do |t|
      t.integer :round
      t.integer :pick
      t.integer :team_id
      t.integer :player_id
      t.boolean :executed, default: false
    end
  end
end
