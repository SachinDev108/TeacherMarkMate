class Grade < ApplicationRecord
  belongs_to :subject
  has_many :details
  validates :name, :marks, :abr, presence: true
end
