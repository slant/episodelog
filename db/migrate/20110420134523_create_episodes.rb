class CreateEpisodes < ActiveRecord::Migration
  def self.up
    create_table :episodes, :force => true do |t|
      t.integer :show_id
      t.integer :season
      t.integer :episode
      t.string :name
      t.date :air_date
      t.text :synopsis
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :episodes
  end
end
