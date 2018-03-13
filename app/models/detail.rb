class Detail < ApplicationRecord
  belongs_to :sheet
  belongs_to :child

  #scope
  scope :updated_in_between, -> (start_at, end_at) { where(updated_at: (start_at)..(end_at)) }

  def grade
    Grade.find_by_id(grade_id)
  end
end
