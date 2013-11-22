class Account < ActiveRecord::Base
	belongt_to :customer
	has_many :transactions

	validates :number, presence: true, uniqueness: true
	validates :balance, presence: true, numericality: {greater_than_or_equal_to: 0.0}

	def withdraw(amount)
                new_balance = self.balance - amount
                if amount > 0 && new_balance >= 0
                        self.update_attributes(:balance => new_balance)
                        create_transaction(amount, 'Auszahlung', new_balance, self.id)
                end
        end

        def deposit(amount)
                if amount > 0
                        new_balance = self.balance + amount
                        self.update_attributes(:balance => new_balance)
                        create_transaction(amount, 'Einzahlung', new_balance, self.id)
                end
        end

        def transfer(amount, target_account_number)
                new_balance_for_self = self.balance - amount
                target_account = Account.find_by_number(target_account_number)

                puts target_account.number

                if amount > 0 && new_balance_for_self >= 0 && target_account != nil

                        self.update_attributes(:balance => new_balance_for_self)
                        
                        new_balance_for_target_account = target_account.balance + amount
                        target_account.update_attributes(:balance => new_balance_for_target_account)

                        create_transaction(amount, "transfer zu #{target_account_number}", new_balance_for_self, self.id)
                        create_transaction(amount, "transfer von #{self.number}", new_balance_for_target_account, target_account.id)

                end
        end

        def statement
                customer = Customer.find(self.customer_id)
                transactions = Transaction.where( :account_id => self.id ).to_a

                puts "Kunde: #{customer.first_name} #{customer.last_name}"
                puts "Guthaben: #{self.balance}"

                transactions.each do |transaction|
                        puts transaction.description 
                end
        end

        private

        def create_transaction(amount, reference, new_balance, id)
                Transaction.create(:amount => amount,:description => reference, :balance_after_transaction => new_balance, :account_id => id)
        end
end
