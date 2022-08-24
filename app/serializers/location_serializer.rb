class LocationSerializer
  include JSONAPI::Serializer
  attributes :id,
             :name,
             :address,
             :url,
             :rating,
             :photos,
             :categories,
             :review_count,
             :price,
             :is_open_now
end
