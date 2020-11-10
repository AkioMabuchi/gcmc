class UserImageUploader < CarrierWave::Uploader::Base

  if Rails.env.production? || Rails.env.staging?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/images/users/"
  end

  def default_url(*args)
    "/NoUserImage.png"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
    "#{model.id}.#{file.extension}"
  end
end
