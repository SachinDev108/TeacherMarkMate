class Recurring < ApplicationRecord
	belongs_to :subcription, optional: true
end
