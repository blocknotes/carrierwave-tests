class Post < ApplicationRecord
  mount_uploader :image1, Image1Uploader
  mount_uploader :image2, Image2Uploader
end
