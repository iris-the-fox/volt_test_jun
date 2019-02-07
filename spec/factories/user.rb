FactoryBot.define do
  factory :user, aliases: [:author], class: User do
    email { "test_exapmple@email.com" }
    nickname { "Test_name"}
    password { "qwerty" }
  end
end