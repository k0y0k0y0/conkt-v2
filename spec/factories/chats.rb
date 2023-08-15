FactoryBot.define do
  factory :chat do
    message { "Sample message" }
    association :room
    association :user
    read { false }
  end
end