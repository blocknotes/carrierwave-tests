class Image5Uploader < CarrierWave::Uploader::Base
  include CarrierWave::ImageOptimizer

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :optimized do
    process optimize: [{ quality: 70 }]
  end
end
