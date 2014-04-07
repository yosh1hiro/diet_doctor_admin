json.array!(@counsels) do |counsel|
  json.extract! counsel, :id
  json.url counsel_url(counsel, format: :json)
end
