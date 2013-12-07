json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :email, :phone, :skype, :birthday, :gender, :lat, :lon
  json.url user_url(user, format: :json)
end
