FactoryBot.define do
  factory :post do
    content { Faker::Beer.name }
    latitude { Random.new().rand(100.0) }
    longitude { Random.new().rand(100.0) }
    is_public { [true, false].sample }
  end
end
