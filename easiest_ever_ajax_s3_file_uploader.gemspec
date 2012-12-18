# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easiest_ever_ajax_s3_file_uploader/version'

Gem::Specification.new do |gem|
  gem.name          = "easiest_ever_ajax_s3_file_uploader"
  gem.version       = EasiestEverAjaxS3FileUploader::VERSION
  gem.authors       = ["Steven Soroka"]
  gem.email         = ["ssoroka78@gmail.com"]
  gem.description   = %q{Easiest Ever Ajax S3 File Uploader}
  gem.summary       = %q{Easiest Ever Ajax S3 File Uploader}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency("ruby-hmac", ["0.4.0"])
  gem.add_dependency("aws-s3", [">= 0.6.3"])
end
