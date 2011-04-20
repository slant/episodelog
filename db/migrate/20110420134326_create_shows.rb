class CreateShows < ActiveRecord::Migration
  def self.up
    create_table :shows, :force => true do |t|
      t.string :name
      t.string :short_name
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :shows
  end
end