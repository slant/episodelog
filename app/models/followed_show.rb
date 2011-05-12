class FollowedShow < ActiveRecord::Base
  belongs_to :user
  belongs_to :show

  validates :show_id, :uniqueness => { :scope => :user_id }
end
