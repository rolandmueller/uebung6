class Account < ActiveRecord::Base
	belongt_to :customer
	has_many :transactions
end
