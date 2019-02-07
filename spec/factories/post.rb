FactoryBot.define do
  factory :post, class: Post do
    title { "Test Title" }
    body { "Test body"}
    published_at {Time.now}
    association :author, strategy: :build
  end
end