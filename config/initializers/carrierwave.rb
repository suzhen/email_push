CarrierWave.configure do |config|
  config.storage = :upyun
  config.upyun_username = 'ccsm'
  config.upyun_password = 'ccsm001001'
  config.upyun_bucket = 'ccsmkj'
  config.upyun_bucket_host = "ccsmkj.b0.upaiyun.com"
end