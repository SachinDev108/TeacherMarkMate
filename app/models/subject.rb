class Subject < ApplicationRecord
  has_many :grades, :dependent => :destroy
  has_many :students
  has_many :children, through: :students
  has_many :sheets, :dependent => :destroy
  belongs_to :teacher
  accepts_nested_attributes_for :grades, allow_destroy: true

  validates :name, :teacher_id, :grades, presence: true
end
