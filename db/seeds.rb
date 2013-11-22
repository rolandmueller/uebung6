# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Kunde1 = Customer.create(:first_name => 'Hans', :last_name => 'Maier', :address => 'Blastr. 1')
Kunde2 = Customer.create(:first_name => 'Ulli', :last_name => 'HuiBu', :address => 'Käse1')

Konto1 = Account.create(:number => 123, :balance => 50.00, :customer_id => Kunde1.id)
Konto2 = Account.create(:number => 456, :balance => 20845.00, :customer_id => Kunde2.id)
Konto3 = Account.create(:number => 789, :balance => 39893.00, :customer_id => Kunde2.id)

Transaktion1 = Transaction.create(:amount => 54.00, :description => 'Geld muss weg!', :balance_after_transaction => 39839.00, :account_id => Konto3.id)