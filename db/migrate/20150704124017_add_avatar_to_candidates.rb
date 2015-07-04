class AddAvatarToCandidates < ActiveRecord::Migration
  def self.up
    add_attachment :candidates, :avatar
  end

  def self.down
    remove_attachment :candidates, :avatar
  end
end
