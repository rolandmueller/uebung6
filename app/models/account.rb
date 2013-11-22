class Account < ActiveRecord::Base
	belongt_to :customer
	has_many :transactions

	validates :number, presence: true, uniqueness: true
	validates :balance, presence: true, numericality: {greater_than_or_equal_to: 0.0}

	def withdraw(betrag)
                kontostand_neu = self.balance - betrag
                if betrag > 0 && kontostand_neu >= 0
                        self.update_attributes(:balance => kontostand_neu)
                        create_transaction(betrag, 'Auszahlung', kontostand_neu, self.id)
                end
        end

        def deposit(betrag)
                if betrag > 0
                        kontostand_neu = self.balance + betrag
                        self.update_attributes(:balance => kontostand_neu)
                        create_transaction(betrag, 'Einzahlung', kontostand_neu, self.id)
                end
        end

        def transfer(betrag, target_account_number)
                kontostand_neu_for_self = self.balance - betrag
                target_account = Account.find_by_number(target_account_number)

                puts target_account.number

                if betrag > 0 && kontostand_neu_for_self >= 0 && target_account != nil

                        self.update_attributes(:balance => kontostand_neu_for_self)
                        
                        kontostand_neu_for_target_account = target_account.balance + betrag
                        target_account.update_attributes(:balance => kontostand_neu_for_target_account)

                        create_transaction(betrag, "transfer zu #{target_account_number}", kontostand_neu_for_self, self.id)
                        create_transaction(betrag, "transfer von #{self.number}", kontostand_neu_for_target_account, target_account.id)

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

        def create_transaction(betrag, referenz, kontostand_neu, id)
                Transaction.create(:betrag => betrag,:description => referenz, :balance_after_transaction => kontostand_neu, :account_id => id)
        end
end
