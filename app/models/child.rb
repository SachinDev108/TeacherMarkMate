class Child < ApplicationRecord
	belongs_to :teacher
	has_many :students
	has_many :subjects, through: :students

	accepts_nested_attributes_for :students, :allow_destroy => true
end
