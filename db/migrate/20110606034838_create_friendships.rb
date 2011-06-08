class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.string :user_id
      t.string :friend_id
      t.string :validation_code
      t.boolean :accepted, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :friendships
  end
end
