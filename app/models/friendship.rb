class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => 'User'

  validates :friend_id, :uniqueness => { :scope => :user_id }

  def accept(validation_code)
    if self.validation_code == validation_code
      self.update_attribute(:accepted, true)
    end
  end
end
