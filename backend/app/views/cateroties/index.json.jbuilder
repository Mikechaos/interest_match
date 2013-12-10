json.array!(@cateroties) do |cateroty|
  json.extract! cateroty, :id, :name
  json.url cateroty_url(cateroty, format: :json)
end
