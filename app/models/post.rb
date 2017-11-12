class Post < ApplicationRecord
  mount_uploader :image1, Image1Uploader
  mount_uploader :image2, Image2Uploader
  mount_uploader :image3, Image3Uploader
  mount_uploader :image4, Image4Uploader
  mount_uploader :image5, Image5Uploader

  has_one :extra_image, class_name: 'Image', dependent: :destroy, as: :imageable

  validates :title, presence: true, allow_blank: false
  accepts_nested_attributes_for :extra_image, reject_if: :all_blank, allow_destroy: true
end
