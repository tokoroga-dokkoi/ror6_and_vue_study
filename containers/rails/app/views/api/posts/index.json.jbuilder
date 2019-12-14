json.array! @posts do |post|
    json.content post.content
    json.latitude post.latitude
    json.longitude post.longitude
    json.image rails_blob_url(post.picture) if post.picture.attached?
end