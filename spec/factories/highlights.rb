FactoryBot.define do
  factory :highlight do
    book
    content "アイウエオ"
    location 677
    annotation_id "ABC123456"
    note ""
    note_id ""
    fetched_at 22.hours.ago
  end

end
