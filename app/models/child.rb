class Child < ApplicationRecord
	belongs_to :teacher
	has_many :details, :dependent => :destroy
	has_many :students, :dependent => :destroy
	has_many :subjects, through: :students

	accepts_nested_attributes_for :students, :allow_destroy => true
	validates :name, presence: true
	validates :students, presence: true
end
