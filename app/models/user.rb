class User < ActiveRecord::Base
  has_many :followed_shows
  has_many :shows, :through => :followed_shows

  has_many :watched_episodes
  has_many :episodes, :through => :watched_episodes

  has_many :friendships
  has_many :friends, :through => :friendships

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def admin
    false
  end

  def name
    [first_name, last_name].join(' ')
  end
end
