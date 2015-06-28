class AddDeletedToElectionAllowedEmails < ActiveRecord::Migration
  def change
    add_column :election_allowed_emails, :deleted, :boolean, default: false
  end
end
