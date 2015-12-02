class Book < ActiveRecord::Base
  has_many :highlights

  def self.recent(size = 5)
    order(last_annotated_on: :desc).limit(size)
  end

  def highlight_summary
    highlights.map{|h| [h.content, (h.note.present? ? '[Note]' + h.note.gsub(/\s/, ' ') : nil) ].compact }.flatten
  end
end
