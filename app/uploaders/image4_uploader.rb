class Image4Uploader < CarrierWave::Uploader::Base

  include CarrierWave::Vips

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  def resize_and_pad(new_width, new_height, opts = {})
    manipulate! do |image|
      image = resize_image(image,new_width,new_height)
      image.embed ( new_width - image.width ) / 2, ( new_height - image.height ) / 2, new_width, new_height, opts
    end
  end

  # Create different versions of your uploaded files:
  version :fit do
    process resize_to_fit: [100, 100]
  end

  version :fill do
    process resize_to_fill: [100, 100]
  end

  # version :limit do
  #   process resize_to_limit: [100, 100]
  # end

  version :pad do
    process resize_and_pad: [100, 100, :background => [0, 128, 100]]
    # process resize_and_pad: [100, 100, :extend => 'copy']
    # process resize_and_pad: [100, 100]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
