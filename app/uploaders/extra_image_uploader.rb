class ExtraImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :news, if: :is_news?

  version :post, if: :is_post?

  private

    def is_news?( image )
      model.imageable_type && model.imageable_type == 'News'  # TODO: not working
    end

    def is_post?( image )
      model.imageable_type && model.imageable_type == 'Post'  # TODO: not working
    end

end
