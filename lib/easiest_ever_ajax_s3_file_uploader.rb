require "easiest_ever_ajax_s3_file_uploader/version"
require "easiest_ever_ajax_s3_file_uploader/d2s3"
require "easiest_ever_ajax_s3_file_uploader/active_record_extension"

module EasiestEverAjaxS3FileUploader
  class Engine < Rails::Engine
    paths["app/assets"] << "lib/assets"
  end
end
