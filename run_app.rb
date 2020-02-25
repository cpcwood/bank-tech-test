require './lib/bank_account'
require './lib/bank_ui'

new_user = BankUi.new(outputter: STDOUT, inputter: STDIN, bank_account: BankAccount.new)
new_user.run_bank_ui
