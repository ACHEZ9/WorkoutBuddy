json.array!(@events) do |event|
  json.extract! event, :id, :name, :description, :tag, :text, :time, :datetime, :location, :string, :image_url, :string
  json.url event_url(event, format: :json)
end
