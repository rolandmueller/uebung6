class Account < ActiveRecord::Base
	belongt_to :customer
	has_many :transactions

	validates :number, presence: true, uniqueness: true
	validates :balance, presence: true, numericality: {greater_than_or_equal_to: 0.0}
end
