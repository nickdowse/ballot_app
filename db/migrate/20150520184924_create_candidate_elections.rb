class CreateCandidateElections < ActiveRecord::Migration
  def change
    create_table :candidate_elections, :id => false do |t|
      t.integer :candidate_id
      t.integer :election_id

      t.timestamps
    end
  end
end
