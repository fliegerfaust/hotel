json.array!(@rooms) do |room|
  json.extract! room, :id, :title, :roomtype, :description, :image_url, :quantity, :price
  json.url room_url(room, format: :json)
end
