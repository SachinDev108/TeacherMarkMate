class Subject < ApplicationRecord
  belongs_to :teacher
  has_many :students
  has_many :children, through: :students
end
