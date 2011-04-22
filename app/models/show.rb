class Show < ActiveRecord::Base
  has_many :followed_shows
  has_many :users, :through => :followed_shows

  has_many :episodes, :dependent => :destroy

  validates_uniqueness_of :name, :short_name
end
