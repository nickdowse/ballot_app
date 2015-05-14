class CreateAllowedEmails < ActiveRecord::Migration
  def change
    create_table :allowed_emails do |t|
      t.string :email
      t.integer :organisation_id
    end
  end
end
