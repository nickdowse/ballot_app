class AddDeletedToOrganisations < ActiveRecord::Migration
  def change
    add_column :organisations, :deleted, :boolean, default: false
  end
end
