json.array!(@panels) do |panel|
  json.extract! panel, :id
  json.url panel_url(panel, format: :json)
end
