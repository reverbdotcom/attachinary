# Attachinary

Need lightweight attachment (photos and raw files) handler for any of your model, in either has\_one or has\_many relation, without altering your models' schema and with zero effort? Attachinary is the tool for you!

Why is Attachinary different:

* **No need to alter your model schema** any time you introduce new kind of attachment.
* Handles **both has\_one and has\_many** use cases.
* **No need for ImageMagick** (or similar) - your thumbnails are generated on the fly by Cloudinary.
* Fully customizable, built-in **jQuery plugin** for async file uploads with previews.
* **Files are uploaded directly to Cloudinary** completely bypassing your app (without affecting its performance).
* **Very easy to use**. Once set up, 1 line is enough to add attachment support to your model. **No migrations, no Uploaders**.
* **Lightweight form submission**. Attachinary handles file upload asynchronously and the only thing that is passed to your server are the IDs of the files. That makes form postbacks fast and reliable.
* All the [benefits of Cloudinary](http://cloudinary.com/documentation/image_transformations) (resizing, cropping, rotating, rounding corners, **face detection**...).

Attachinary uses [Cloudinary](http://cloudinary.com) service. Gem is structured as mountable rails engine.


## Installation

First, make sure that you have [cloudinary gem](https://github.com/cloudinary/cloudinary_gem) installed and properly configured. Also, make sure that you have following line in head section of your application layout file:

	<%= cloudinary_js_config %>

Then, add following line to your `Gemfile`:

    gem 'attachinary'

Run following rake command in terminal to create necessary tables:

	rake attachinary:install:migrations
	rake db:migrate

Add following line in your `routes.rb` file to mount the engine:

	mount Attachinary::Engine => "/attachinary"




## Usage

Lets say that we want all of our **users** to have single **avatar** and many **photos** in their gallery. We also want *avatar* to be required. We also want to limit the number of photos user can upload to 10. We can declare it like this:

	class User < ActiveRecord::Base
		...
		has_attachment  :avatar, accept: ['jpg', 'png', 'gif']
		has_attachments :photos, maximum: 10

		validates :avatar_id, presence: true
		...
	end

In our `_form.html.erb` template, we need to add only this:

	<%= attachinary_file_field_tag 'user[avatar_id]', user.avatar_id, attachinary: user.avatar_options %>
	<%= attachinary_file_field_tag 'user[photo_ids]', user.photo_ids, attachinary: user.photo_options %>

If you're using [SimpleForm](https://github.com/plataformatec/simple_form), you can even shorten this to:

	<%= f.input :avatar, as: :attachinary %>
	<%= f.input :photos, as: :attachinary %>

Finally, you have to include `attachinary` into your asset pipeline. In your `application.js`, add following line:

	...
	//= require attachinary
	...

And, add this code on document ready:

	$('.attachinary-input').attachinary()

Attachinary jquery plugin is based upon [jQuery File Upload plugin](https://github.com/blueimp/jQuery-File-Upload) but without any fancy UI (it leaves it up to you to decorate it).

Plugin is fully customizable. It uses John Resig's micro templating in the background, but you can override it with whatever you like. Check out the source code for more configuration options you can set.

### Displaying avatar and photos

Here comes the good part. There is no need to transform images on your server. Instead, you can request image transformations directly from Cloudinary. First time you request image, it is created and cached on the Cloudinary server for later use. Here is sample code that you can use in your `_user.html.erb` partial:

	<% if @user.avatar? %>
		<%= cl_image_tag(@user.avatar.path, { size: '50x50', crop: :face }) %>
	<% end %>

	<% @user.photos.each do |photo| %>
		<%= cl_image_tag(photo.path, { size: '125x125', crop: :fit }) %>
	<% end %>

Avatar will be automatically cropped to 50x50px to show only user face. You read it right: **face detection** :) All other user photos are just cropped to fit within 125x125.

Whenever you feel like changing image sizes, you don't need to set rake task that will take forever to re-process thousands of photos. You just change the dimension in your partial and thats it.


## Conventions

* always use singular identifier after `has_attachment` (e.g. `has_attachment :photo`)
* always use plural identifier after `has_attachments` (e.g. `has_attachments :photos`)


## Requirements and Compatibility

* Cloudinary
* Ruby 1.9
* Rails 3.2+
* jQuery


## Credits and License

Developed by Milovan Zogovic.

This software is released under the MIT License.
