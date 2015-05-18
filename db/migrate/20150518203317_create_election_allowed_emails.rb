class CreateElectionAllowedEmails < ActiveRecord::Migration
  def change
    create_table :election_allowed_emails do |t|
      t.string :email
      t.datetime :created_at
      t.integer :election_id
      t.integer :organisation_id
      t.string :created_by

      t.timestamps null: false
    end
  end
end
