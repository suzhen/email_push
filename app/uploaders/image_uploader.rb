# encoding: utf-8
IMAGE_UPLOADER_ALLOW_IMAGE_VERSION_NAMES = %w(image1 image2)
class ImageUploader < CarrierWave::Uploader::Base
  storage :upyun

  # def default_url
  #   # 搞一个大一点的默认图片取名 blank.png 用 FTP 传入图片空间，用于作为默认图片
  #   # 由于有自动的缩略图处理，小图也不成问题
  #   # Setting.upload_url 这个是你的图片空间 URL
  #   "#{Setting.upload_url}/blank.png#{version_name}"
  # end


  def store_dir
    "#{model.class.to_s.demodulize.underscore}/#{model.id.to_s}/#{mounted_as}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    if super.present?
      model.uploader_secure_token ||= SecureRandom.uuid.gsub("-","")
      "#{model.uploader_secure_token}.#{file.extension.downcase}"
    end
  end

  def url(version_name = "")
    @url ||= super({})
    version_name = version_name.to_s
    return @url if version_name.blank?
    if not IMAGE_UPLOADER_ALLOW_IMAGE_VERSION_NAMES.include?(version_name)
      raise "ImageUploader version_name:#{version_name} not allow."
    end
    [@url,version_name].join("!")
  end
end
