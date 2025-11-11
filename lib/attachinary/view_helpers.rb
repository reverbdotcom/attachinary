require 'mime/types'

module Attachinary
  module ViewHelpers

    def builder_attachinary_file_field_tag(attr_name, builder, options={})
      options = attachinary_file_field_options(builder.object, attr_name, options)
      builder.file_field(attr_name, options[:html])
    end

    def attachinary_file_field_tag(field_name, model, relation, options={})
      options = attachinary_file_field_options(model, relation, options)
      file_field_tag(field_name, options[:html])
    end

    def attachinary_file_field_options(model, relation, options={})
      options[:attachinary] = model.send("#{relation}_metadata")

      if options[:upload_to_s3]
        upload_url = Reverb::AWS::BuildPresignedS3Url.build_presigned_s3_url(
          key:,
          bucket: Reverb.config.amazon_s3.images_bucket,
        )

        #{ PUT request requires no form_data. I really don't know if this works/does anything..}
        options[:html] ||= {}
        options[:html][:data] ||= {}

        # TODO - might be able to remove, I don't really know if this works
        options[:html][:data][:upload_method] = 'PUT'

        # Set content type to the actual file type instead of multipart/form-data
        # because right now, the S3 PUT passes (200), but somehow header is content-type :   multipart/form-data; boundary=----WebKitFormBoundaryvvY8JWJcSaMd6I9D
        # options[:html][:data][:content_type] = TODO


      else
        options[:cloudinary] ||= options[:attachinary][:cloudinary] || {}
        options[:cloudinary][:tags] ||= []
        options[:cloudinary][:tags]<< "#{Rails.env}_env"
        options[:cloudinary][:tags]<< Attachinary::TMPTAG
        options[:cloudinary][:tags].uniq!
        options[:cloudinary][:allowed_formats] ||= options[:attachinary][:accept]

        upload_url = Cloudinary::Utils.cloudinary_api_url("upload",
          {:resource_type=>:auto}.merge(options[:cloudinary]))

        api_key = options[:cloudinary][:api_key] || Cloudinary.config.api_key || raise("Must supply api_key")
        api_secret = options[:cloudinary][:api_secret] || Cloudinary.config.api_secret || raise("Must supply api_secret")

        cloudinary_params = Cloudinary::Uploader.build_upload_params(options[:cloudinary])
        cloudinary_params[:callback] = attachinary.cors_url
        cloudinary_params[:signature] = Cloudinary::Utils.api_sign_request(cloudinary_params, api_secret)
        cloudinary_params[:api_key] = api_key

        options[:html][:data][:form_data] = cloudinary_params.reject{ |k, v| v.blank? }
      end

      options[:html] ||= {}
      options[:html][:class] = [options[:html][:class], 'attachinary-input'].flatten.compact

      if !options[:html][:accept] && accepted_types = options[:attachinary][:accept]
        accept = accepted_types.map do |type|
          MIME::Types.type_for(type.to_s)[0]
        end.compact
        options[:html][:accept] = accept.join(',') unless accept.empty?
      end

      options[:html][:multiple] = true unless options[:attachinary][:single]

      options[:html][:data] ||= {}
      options[:html][:data][:attachinary] = options[:attachinary] || {}
      options[:html][:data][:attachinary][:files] = [model.send(relation)].compact.flatten.map do |file|
        file.as_json(options)
      end

      options[:html][:data][:url] = upload_url

      options
    end

    def file_extension
      extension =  '.jpg'

      raise StandardError.new('invalid file format') unless Reverb::Image::Upload::ALLOWED_EXTENSIONS.include?(extension)

      extension
    end

    def key
      Reverb::Image::Upload::FILE_KEY_PREFIX + Reverb.config.amazon_s3.images_bucket + Reverb::Image::Upload::FILE_KEY_SUFFIX + public_id + file_extension

    end

    def public_id
      @_public_id ||= SecureRandom.uuid
    end

  end
end
