class User < ActiveRecord::Base
  include Clearance::User

  has_many :items, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name, name_convention: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  ROLES = %w[admin moderator user]

  def self.search(search)
    if search
      find(:all, :conditions => ['name ILIKE ? OR email ILIKE?', "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end
end
