FactoryBot.define do
  factory :book do
    asin "TEST123456"
    title "テスト"
    author "山田太郎"
    last_annotated_on Date.yesterday
  end

end
