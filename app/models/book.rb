class Book < ActiveRecord::Base
  has_many :highlights
end
