class Customer < ActiveRecord::Base
	belongs_to :account
	has_many :transactions, :through => :accounts

	validates :first_name, presence: true
	validates :last_name, presence: true
end

