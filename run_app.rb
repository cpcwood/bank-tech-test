require 'bank_account'
require 'bank_ui'

new_user = BankUi.new(BankAccount.new)
new_user.start_banking
