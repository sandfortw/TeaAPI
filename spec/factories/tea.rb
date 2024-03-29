# frozen_string_literal: true

FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Tea.type }
    temperature { Faker::Number.between(from: 120, to: 212) }
    brew_time { Faker::Number.between(from: 1, to: 10) }
  end
end
