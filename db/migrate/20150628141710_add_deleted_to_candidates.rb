class AddDeletedToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :deleted, :boolean, default: false
  end
end
