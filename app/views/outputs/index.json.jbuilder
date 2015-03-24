json.array!(@outputs) do |output|
   json.x output.created_at.to_i*1000
   json.y output.watt
end
