require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

# case Rails.env
# when 'development'
#   config.storage :file
# when 'production'

CarrierWave.configure do |config|
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory = 'achieve-production-dpro'
    config.fog_credentials = {
        provider:              'AWS',
        aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"],
        aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
        region:                'ap-northeast-1',
        path_style:            true,
    }

  #   config.fog_public     = false
  #   config.fog_attributes = {'Cache-Control' => 'public, max-age=86400'}

  #   config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/achieve-production-dpro'
  #   # config.fog_directory = 'achieve-development-dpro'
  #   # config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/achieve-development-dpro'
  # end
end