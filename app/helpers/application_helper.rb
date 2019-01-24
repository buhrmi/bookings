require 'signet/oauth_2/client'

module ApplicationHelper
  def google_calendar_auth_path
    client = Signet::OAuth2::Client.new({
      client_id: Rails.application.credentials.google_sign_in[:client_id],
      client_secret: Rails.application.credentials.google_sign_in[:client_secret],
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      scope: 'email profile https://www.googleapis.com/auth/calendar.events',
      redirect_uri: sessions_url,
      additional_parameters: {"access_type" => "offline", 'prompt' => 'consent'}
    })
    client.authorization_uri.to_s
  end
end
