class Book < ActiveRecord::Base
  has_many :highlights

  def highlight_summary
    highlights.map{|h| [h.content, (h.note.present? ? '[Note]' + h.note.gsub(/\s/, ' ') : nil) ].compact }.flatten
  end
end
