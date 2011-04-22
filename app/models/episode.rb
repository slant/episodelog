class Episode < ActiveRecord::Base
  has_many :watched_episodes
  has_many :users, :through => :watched_episodes

  belongs_to :show
end
