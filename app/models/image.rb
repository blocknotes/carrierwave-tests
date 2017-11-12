class Image < ApplicationRecord
  attr_accessor :polymorphic_type

  after_save :on_after_save

  mount_uploader :data, ExtraImageUploader

  belongs_to :imageable, polymorphic: true, touch: true

  validates :data, presence: true

  def filename
    read_attribute 'data' if data
  end

  protected
    def on_after_save
      self.imageable.touch if saved_change_to_attribute?( :data ) && self.imageable
    end
end
