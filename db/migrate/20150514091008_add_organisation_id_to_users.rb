class AddOrganisationIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :organisation_id, :integer, null: false
  end
end
