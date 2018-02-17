class Sheet < ApplicationRecord
  belongs_to :teacher
  has_many :details, :dependent => :destroy
  belongs_to :subject

  accepts_nested_attributes_for :details, allow_destroy: true

  validates :title, :subject_id, :teacher_id, :date, presence: true
end
