class CreateEpisodesWatched < ActiveRecord::Migration
  def self.up
    create_table :episodes_watched, :force => true do |t|
      t.integer :user_id
      t.integer :episode_id
      t.timestamps
    end
  end

  def self.down
    drop_table :episodes_watched
  end
end
