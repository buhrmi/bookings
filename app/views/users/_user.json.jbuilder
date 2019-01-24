json.extract! user, :id, :artist_name, :name, :created_at, :updated_at
json.url user_url(user, format: :json)
