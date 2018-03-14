class Subscription < ApplicationRecord
  
  belongs_to :subscription_type
  belongs_to :teacher

  scope :is_active, -> { where(:status => true) }

  def is_individual?
    try(:subscription_type).try(:name) == "Individual Plan"
  end
end
