# Project setup

```ruby
rails g scaffold Post title:string description:text image1:string image2:string image3:string image4:string image5:string image6:string image7:string image8:string image9:string
rails g model Image data:string
# Added polymorphic reference to Image
rails g scaffold News title:string description:text
```

## Experiments

```ruby
post = Post.find_or_create_by title: 'A post'
post.image1 = File.open Rails.root.join( 'lib', 'image1.jpg' )
post.save
```

### Image Processing

#### [MiniMagick](https://github.com/minimagick/minimagick) (requires ImageMagick)

[uploader sample](app/uploaders/image2_uploader.rb)

`gem 'mini_magick'`

```ruby
process resize_to_fit:  [100, 100]  # resize (dimensions may be less than required)
process resize_to_fill: [100, 100]  # crop image
process resize_and_pad: [100, 100]  # extend image
```

#### [RMagick](https://github.com/rmagick/rmagick) (requires ImageMagick)

[uploader sample](app/uploaders/image3_uploader.rb)

`gem 'rmagick'`

```ruby
process resize_to_fit:  [100, 100]  # resize (dimensions may be less than required)
process resize_to_fill: [100, 100]  # crop image
process resize_and_pad: [100, 100]  # extend image
```

#### [CarrierWave Vips](https://github.com/eltiare/carrierwave-vips) (requires LibVips)

[uploader sample](app/uploaders/image4_uploader.rb)

`gem 'carrierwave-vips'`

```ruby
def resize_and_pad(new_width, new_height, opts = {})
  manipulate! do |image|
    image = resize_image(image,new_width,new_height)
    image.embed ( new_width - image.width ) / 2, ( new_height - image.height ) / 2, new_width, new_height, opts
  end
end
```

```ruby
process resize_to_fit:  [100, 100]  # resize (dimensions may be less than required)
process resize_to_fill: [100, 100]  # crop image
process resize_and_pad: [100, 100, :background => [0, 128, 192]]  # extend image
```

#### [CarrierWave ImageOptimizer](https://github.com/jtescher/carrierwave-imageoptimizer) (requires jpegoptim optipng pngquant)

[uploader sample](app/uploaders/image5_uploader.rb)

`gem 'carrierwave-imageoptimizer'`

```ruby
process optimize: [{ quality: 50 }]
```

### Polymorphic Image

```ruby
post = Post.find_or_create_by title: 'A post'
post.build_extra_image data: File.open( Rails.root.join( 'lib', 'image1.jpg' ) )
post.save
# post.extra_image.data.url
news = News.find_or_create_by title: 'A news'
news.build_extra_image data: File.open( Rails.root.join( 'lib', 'image1.jpg' ) )
news.save
# news.extra_image.data.url
```
