class Item < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, length: { maximum: 75 }
  validates :description, length: { maximum: 1000 }
  validates :user_id, presence: true
end
