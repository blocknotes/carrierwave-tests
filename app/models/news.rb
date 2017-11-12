class News < ApplicationRecord
  has_one :extra_image, class_name: 'Image', dependent: :destroy, as: :imageable

  validates :title, presence: true, allow_blank: false
  accepts_nested_attributes_for :extra_image, reject_if: :all_blank, allow_destroy: true
end
