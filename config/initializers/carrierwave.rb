require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'
unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.storage :fog
    config.fog_provider = 'fog/aws' # 追加
    config.fog_public = false #一般公開されてないS3の場合必要
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY_ID'],
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'nekoten-s3'
    config.asset_host = 'https://s3.amazonaws.com/nekoten-s3'
  end
end
