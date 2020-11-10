class PortfolioImageUploader < CarrierWave::Uploader::Base

  if Rails.env.production? || Rails.env.staging?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/images/portfolios/"
  end

  def default_url(*args)
    "/NoPortfolioImage.png"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
    "#{model.id}.#{file.extension}"
  end
end
