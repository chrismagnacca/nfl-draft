class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string  :name
      t.string  :position
      t.boolean :drafted, default: false
    end
  end
end
