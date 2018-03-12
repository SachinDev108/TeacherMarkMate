class Subscription < ApplicationRecord
	
	belongs_to :subscription_type
	belongs_to :teacher

	scope :is_active, -> { where(:status => true) }
end
