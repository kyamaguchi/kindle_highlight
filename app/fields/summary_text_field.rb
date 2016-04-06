require "administrate/field/base"

class SummaryTextField < Administrate::Field::Base
  def to_s
    data.join("\n")
  end
end
