class Episode < ActiveRecord::Base
  has_many :watched_episodes
  has_many :users, :through => :watched_episodes

  belongs_to :show

  # scope :by_show, lambda { |show| where(:show_id => show.id).sort_by { |s| self.season } }

  def watched?(user)
    user.episodes.include?(self)
  end
end
