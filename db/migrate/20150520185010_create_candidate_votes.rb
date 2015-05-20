class CreateCandidateVotes < ActiveRecord::Migration
  def change
    create_table :candidate_votes, :id => false do |t|
      t.integer :candidate_id
      t.integer :vote_id

      t.timestamps

    end
  end
end
