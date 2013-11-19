class Transaction < ActiveRecord::Base
	belongs_to :account

	validates :amount, presence: true
	validates :description, presence: true
	validates :balance_after_transaction, presence: true
end
