class Detail < ApplicationRecord
  belongs_to :sheet
  belongs_to :child
  belongs_to :grade
end
