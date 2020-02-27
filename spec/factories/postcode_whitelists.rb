# frozen_string_literal: true

FactoryBot.define do
  factory :postcode_whitelist do
    sequence(:postcode) { |n| "SH24 #{n}AA" }

    trait :inactive do
      active { false }
    end
  end
end
