class Grade < ApplicationRecord
  belongs_to :subject
  validates :name, :marks, :abr, presence: true
end
