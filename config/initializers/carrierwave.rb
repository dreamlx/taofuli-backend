::CarrierWave.configure do |config|
  config.storage             = :qiniu
  config.qiniu_access_key    = Rails.application.secrets.qiniu_access
  config.qiniu_secret_key    = Rails.application.secrets.qiniu_secret
  config.qiniu_bucket        = "sample"
  config.qiniu_bucket_domain = ""
  # config.qiniu_bucket_private= true #default is false
  config.qiniu_block_size    = 4*1024*1024
  config.qiniu_protocol      = "http"
end

if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end