class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value
      t.integer :organisation_id
      t.integer :election_id
      t.integer :user_id
      t.integer :candidate_id
      t.text :history

      t.timestamps null: false
    end
  end
end
