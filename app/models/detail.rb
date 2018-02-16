class Detail < ApplicationRecord
  belongs_to :sheet
  belongs_to :child

  def grade
  	Grade.find_by_id(grade_id)
  end
end
