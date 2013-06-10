# EasiestEverAjaxS3FileUploader

Direct-to-s3 file uploads via ajax. I hate complicated things; This isn't!

This project bundles the d2s3 project from here: https://github.com/mwilliams/d2s3 because why the hell not; make your shit a gem if you don't want stupid things like this to happen.

## Installation

Add this line to your application's Gemfile:

    gem 'easiest_ever_ajax_s3_file_uploader', git: 'git://github.com/ssoroka/easiest_ever_ajax_s3_file_uploader.git'

And then execute:

    $ bundle install

Create a config/s3.yml file:

    development:
      access_key_id: AAAAAAAAAAAAAAAAAAAA
      secret_access_key: a1a1a1a1a1a1a1a1a1a1a1a1a1a/b2b2b2b2b2b2
      bucket: development-bucket-name

    test:
      access_key_id: AAAAAAAAAAAAAAAAAAAA
      secret_access_key: a1a1a1a1a1a1a1a1a1a1a1a1a1a/b2b2b2b2b2b2
      bucket: test-bucket-name

    production:
      access_key_id: AAAAAAAAAAAAAAAAAAAA
      secret_access_key: a1a1a1a1a1a1a1a1a1a1a1a1a1a/b2b2b2b2b2b2
      bucket: production-bucket-name

(don't reuse the production bucket for dev or test) :)

in app/assets/javascripts/application.js add this line (before require application):

    //= require easiest_ever_ajax_uploads

Now all that's left is to define your own custom handlers for what to do when files are uploaded.  See examples/application.js to see what this should look like.

    EasiestAjaxUploader.uploadStarted = function(input, form, uploadsInProgressCount) {}

    // fired on upload success. use this to update the page UI.
    EasiestAjaxUploader.uploadSuccess = function(input, form, filename, preview_url, uploadsInProgressCount) {}

    // fired on upload failure
    EasiestAjaxUploader.uploadError = function(input, form, message, xhttp_request_object) {}

    // fired on completion regardless of success or failure, use for spinners, ui changes, etc.
    EasiestAjaxUploader.uploadDone = function(input, form, uploadsInProgressCount) {}

Add a string field to your model to hold the file's s3 url.

    eg: add_column :posts, :image_url, :string

and add the url handler to the model:

    easiest_ajax_upload_field :image_url

Add an initializer (should this be a before_filter? does it actually connect?) that connects to s3, so the url handler can look up the full url from s3 when the model is saved:

    AWS::S3::Base.establish_connection!(
      :access_key_id => D2S3::S3Config.access_key_id,
      :secret_access_key => D2S3::S3Config.secret_access_key,
      :server => "#{D2S3::S3Config.bucket}.s3.amazonaws.com"
    )

Most importantly, You have to edit the CORS configuration for your Amazon S3 bucket to look something like the following:

    <?xml version="1.0" encoding="UTF-8"?>
    <CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
        <CORSRule>
            <AllowedOrigin>http://example.com</AllowedOrigin>
            <AllowedOrigin>https://example.com</AllowedOrigin>
            <AllowedMethod>PUT</AllowedMethod>
            <AllowedMethod>POST</AllowedMethod>
            <AllowedMethod>DELETE</AllowedMethod>
            <ExposeHeader>Location</ExposeHeader>
            <AllowedHeader>*</AllowedHeader>
        </CORSRule>
        <CORSRule>
            <AllowedOrigin>*</AllowedOrigin>
            <AllowedMethod>GET</AllowedMethod>
            <MaxAgeSeconds>3000</MaxAgeSeconds>
            <AllowedHeader>Authorization</AllowedHeader>
        </CORSRule>
    </CORSConfiguration>

Feel free to edit as neccessary, but AllowedOrigin must match your host domain, and the ExposeHeader is required.

## Usage

If you want to be able to dynamically insert these file input forms, do something like this:

    <%= javascript_tag do %>
      window.uploadForm = '<%= s3_upload_form %>';
    <% end %>

to use it in a view:

    <%= s3_upload_form %>

If you want more controls over how it renders the form and input, see https://github.com/mwilliams/d2s3#options

## Requirements

  JQuery for the ajaxy bits.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
