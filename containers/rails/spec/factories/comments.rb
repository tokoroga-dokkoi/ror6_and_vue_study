FactoryBot.define do
  factory :comment do
    content { Faker::String.random(length: 3..199)}

    trait :too_long_comment do
      content { Faker::String.random(length: 201)}
    end
  end
end
