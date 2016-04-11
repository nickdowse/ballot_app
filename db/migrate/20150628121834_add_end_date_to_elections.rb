class AddEndDateToElections < ActiveRecord::Migration
  def change
    add_column :elections, :end_date, :datetime
  end
end
