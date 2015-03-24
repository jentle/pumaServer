json.array!(@devices) do |device|
  json.extract! device, :id, :device_id, :name, :port, :ip
  json.url device_url(device, format: :json)
end
