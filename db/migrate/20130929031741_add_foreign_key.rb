class AddForeignKey < ActiveRecord::Migration
  def change
    add_column :players, :draft_id, :integer
  end
end
