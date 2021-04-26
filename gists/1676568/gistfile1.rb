# The current configuration for CarrierWave

CarrierWave.configure do |config|
  config.storage              = :s3
  config.s3_access_policy     = :public_read
  config.s3_access_key_id     = S3_CONFIG['access_key_id']
  config.s3_secret_access_key = S3_CONFIG['secret_access_key']
  config.s3_bucket            = S3_CONFIG['bucket']
end