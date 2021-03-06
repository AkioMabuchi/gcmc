class UserImageUploader < CarrierWave::Uploader::Base

  if Rails.env.production? || Rails.env.staging?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/images/users/#{model.id}"
  end

  def default_url(*args)
    "/NoUserImage.png"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
    "image.#{file.extension}" if original_filename.present?
  end
end
