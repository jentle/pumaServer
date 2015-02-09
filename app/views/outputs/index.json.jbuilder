json.array!(@outputs) do |output|
  json.extract! output, :id, :watt, :voltage
  json.url output_url(output, format: :json)
end
