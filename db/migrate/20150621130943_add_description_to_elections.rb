class AddDescriptionToElections < ActiveRecord::Migration
  def change
    add_column :elections, :description, :text
  end
end
