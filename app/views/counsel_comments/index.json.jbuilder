json.array!(@counsel_comments) do |counsel_comment|
  json.extract! counsel_comment, :id
  json.url counsel_comment_url(counsel_comment, format: :json)
end
