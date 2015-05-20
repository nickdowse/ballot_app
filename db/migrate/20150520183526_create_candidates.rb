class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name
      t.integer :organisation_id
      t.text :description

      t.timestamps null: false
    end
  end
end
