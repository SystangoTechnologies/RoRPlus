class AccessToken < ApplicationRecord
  # Associations
  belongs_to :user

  before_create :generate_token

  private
  def generate_token
    begin
      exp = Time.zone.now.to_i + GlobalConstants::ACCESS_TOKEN_EXPIRY_IN_DAYS.days.to_i
      exp_payload = { :data => 'ror_plus_api', :exp => exp }
      token = JWT.encode exp_payload, Rails.application.credentials.development[:api_hmac_secret], 'HS256'
      self.token = token
    end while self.class.exists?(token: token)
  end
end
