class User < ApplicationRecord
  def google_client
    @google_client ||= Signet::OAuth2::Client.new(
      client_id: Rails.application.credentials.google_sign_in[:client_id],
      client_secret: Rails.application.credentials.google_sign_in[:client_secret],
      access_token: self.google_calendar_token,
      refresh_token: self.google_calendar_refresh_token,
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
    )
  end
end
