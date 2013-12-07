json.array!(@interests) do |interest|
  json.extract! interest, :id, :name, :description, :lat, :lon, :user_id
  json.url interest_url(interest, format: :json)
end
