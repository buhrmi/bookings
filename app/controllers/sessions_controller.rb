require 'google/apis/oauth2_v2'

class SessionsController < ApplicationController
  skip_before_action :require_user, only: [:show]

  def show
    if user = authenticate_with_google
      token = AccessToken.create!(user: user)
      # XXX: set secure and http_only cookie
      cookies[:access_token] = token.token
      redirect_back(fallback_location: root_path, success: 'logged_in')
    else
      redirect_back(fallback_location: root_path, alert: 'authentication_failed')
    end
  end

  def destroy
    cookies[:access_token] = nil
    redirect_to root_path, success: 'logged_out'
  end

  private
    def authenticate_with_google
      client = Signet::OAuth2::Client.new({
        client_id: Rails.application.credentials.google_sign_in[:client_id],
        client_secret: Rails.application.credentials.google_sign_in[:client_secret],
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        redirect_uri: sessions_url,
        code: params[:code]
      })
      
      response = client.fetch_access_token!

      service = Google::Apis::Oauth2V2::Oauth2Service.new
      service.authorization = client
      user_info = service.get_userinfo

      # TODO: use user_info.picture for profile pic
      user = User.find_or_create_by(google_id: user_info.id)
      user.update_attributes(
        google_access_token: response['access_token'],
        google_refresh_token: response['refresh_token'],
        name: user_info.name,
        email: user_info.email,
        email_verified: user_info.verified_email
      )
      user
    end
end
