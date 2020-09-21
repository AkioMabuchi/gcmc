class SignupConfirmation < ApplicationRecord
  attr_encrypted :password, key: 'This is a key that is 256 bits!!'
end
