json.array!(@events) do |event|
  json.extract! event, :id, :name, :desc, :time, :location, :image
  json.url event_url(event, format: :json)
end
