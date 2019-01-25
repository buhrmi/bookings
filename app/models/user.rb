require 'google/apis/calendar_v3'

class User < ApplicationRecord
  def google_client
    @google_client ||= Signet::OAuth2::Client.new(
      client_id: Rails.application.credentials.google_sign_in[:client_id],
      client_secret: Rails.application.credentials.google_sign_in[:client_secret],
      access_token: self.google_access_token,
      refresh_token: self.google_refresh_token,
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
    )
  end

  def calendars
    return @calendar_list if @calendar_list
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = google_client
    @calendar_list = service.list_calendar_lists
    @calendar_list
  end
end
