class Item < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  has_attached_file :item_image, styles: { medium: "300x300>", thumb: "100x100>" },
                                 default_url: "/images/:style/missing.png"

  validates :name, presence: true, length: { maximum: 75 }
  validates :description, length: { maximum: 2000 }
  validates :user_id, presence: true
  validates :address, presence: true

  validates_attachment :item_image,
                        content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
                        matches: [/jpe?g\Z/, /gif\Z/, /png\Z/],
                        size: { less_than: 10.megabytes }



  def self.search(search)
    if search
      where('name ILIKE ?', "%#{search}%").load
    else
      where(@item = true).load
    end
  end

end
