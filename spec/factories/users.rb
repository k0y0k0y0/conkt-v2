FactoryBot.define do
  factory :user do
    email { "test@example.com" }
    password { "12345678" }
    password_confirmation { "12345678" }
    admin { "false" }
  end

  factory :second_user, class: User do
    email { "test_admin@example.com" }
    password { "87654321" }
    password_confirmation { "87654321" }
    admin { "true" }
  end

  factory :third_user, class: User do
    email { "test3@example.com" }
    password { "11111111" }
    password_confirmation { "11111111" }
    admin { "false" }
  end
end