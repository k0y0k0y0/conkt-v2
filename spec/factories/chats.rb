FactoryBot.define do
  factory :chat do
    message { "Sample message" }
    room {:room}
    user {:user}
    read { false }
  end
end