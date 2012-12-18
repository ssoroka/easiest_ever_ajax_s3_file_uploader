module EasiestEverAjaxUploads
  module ActiveRecordExtension
    def easiest_ajax_upload_field(field)
      require 'aws/s3'
      class_eval %(
        def #{field}=(filename)
          write_attribute(#{field.inspect}, self.class.get_s3_access_url(filename))
        end
      )
    end

    def get_s3_access_url(filename)
      if filename.blank? || filename =~ /AWSAccessKeyId/i
        filename
      else
        filename = URI.unescape(filename).match(/(uploads\/[^\/]+)$/)[0].gsub(/\+/, ' ')
        upload = AWS::S3::S3Object.find(filename)
        url = upload.url(:expires => 10.years.from_now.to_i)
        url.gsub!("#{D2S3::S3Config.bucket}/", '')
        url
      end
    end
  end
end

ActiveRecord::Base.extend(EasiestEverAjaxUploads::ActiveRecordExtension)
