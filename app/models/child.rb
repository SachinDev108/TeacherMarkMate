class Child < ApplicationRecord
	belongs_to :teacher
	has_many :details
	has_many :students
	has_many :subjects, through: :students

	accepts_nested_attributes_for :students, :allow_destroy => true
	validates :name, presence: true
end
