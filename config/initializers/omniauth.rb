Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,
           Rails.application.credentials.twitter_api[:key],
           Rails.application.credentials.twitter_api[:secret_key],
           {
               :secure_image_url => true,
               :image_size => "original"
           }
  provider :github,
           Rails.application.credentials.github_api[:key],
           Rails.application.credentials.github_api[:secret_key]
end

OmniAuth.config.on_failure = Proc.new{|env| OmniAuth::FailureEndpoint.new(env).redirect_to_failure}
