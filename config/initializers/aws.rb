ActionMailer::Base.add_delivery_method :ses,
                                       AWS::SES::Base,
                                       access_key_id: Rails.application.credentials.email[:access_key_id],
                                       secret_access_key: Rails.application.credentials.email[:secret_access_key],
                                       server: 'email.ap-northeast-1.amazonaws.com'