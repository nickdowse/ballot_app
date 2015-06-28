class AddEndDateToElections < ActiveRecord::Migration
  def change
    add_column :elections, :end_date, :datetime
    add_column :elections, :state, :string
  end
end
