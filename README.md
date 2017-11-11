# Project setup

```ruby
rails g scaffold Post --skip title:string description:text image1:string image2:string image3:string image4:string image5:string image6:string image7:string image8:string image9:string
rails g model Image data:string
# Added polymorphic reference to Image
```

## Experiments

`Post.create title: 'A post'`

```ruby
post = Post.first
post.image1 = File.open Rails.root.join( 'lib', 'image1.jpg' )
post.save
```
