FactoryBot.define do
  factory :article do
    image   {Faker::Lorem.characters}
    title   {Faker::Lorem.sentence}
    content {Faker::Lorem.paragraphs}
    association :user
  end
end
