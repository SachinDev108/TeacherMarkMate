class Subscription < ApplicationRecord
  
  belongs_to :subscription_type
  belongs_to :teacher

  has_many :recurrings

  scope :is_active, -> { where(:payment_status => 'Completed').order('created_at DESC') }

  def is_individual?
    try(:subscription_type).try(:name) == "Individual Plan"
  end
end
