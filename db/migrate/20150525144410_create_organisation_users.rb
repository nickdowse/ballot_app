class CreateOrganisationUsers < ActiveRecord::Migration
  def change
    create_table :organisation_users, id: false do |t|
      t.integer :user_id
      t.integer :organisation_id
      t.string :role
    end
    add_index :organisation_users, [:user_id, :organisation_id]
  end
end
