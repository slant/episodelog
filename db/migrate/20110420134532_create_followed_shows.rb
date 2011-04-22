class CreateFollowedShows < ActiveRecord::Migration
  def self.up
    create_table :followed_shows, :force => true do |t|
      t.integer :user_id
      t.integer :show_id
      t.timestamps
    end
  end

  def self.down
    drop_table :followed_shows
  end
end
