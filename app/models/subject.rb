class Subject < ApplicationRecord
  belongs_to :teacher
  has_many :students
  has_many :children, through: :students

  validates :name, :teacher_id, presence: true
end
