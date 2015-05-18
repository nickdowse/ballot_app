class CreateElections < ActiveRecord::Migration
  def change
    create_table :elections do |t|
      t.string :title
      t.datetime :created_at
      t.integer :created_by
      t.integer :organisation_id, null: false

      t.timestamps null: false
    end
  end
end
