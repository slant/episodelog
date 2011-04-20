class CreateShowsFollowed < ActiveRecord::Migration
  def self.up
    create_table :shows_followed, :force => true do |t|
      t.integer :user_id
      t.integer :show_id
      t.timestamps
    end
  end

  def self.down
    drop_table :shows_followed
  end
end
