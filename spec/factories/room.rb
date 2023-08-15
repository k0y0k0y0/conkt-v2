FactoryBot.define do
  factory :room do
    sender{:user}
    recipient{:second_user}
  end
end
