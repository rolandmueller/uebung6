class Customer < ActiveRecord::Base
	belongs_to :account
	has_many :transactions, :through => :accounts
end
