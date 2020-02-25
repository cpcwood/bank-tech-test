require 'bank_ui'
require 'bank_account'

describe 'Run App Feature Test' do
  before(:each) do
    @mock_outputter = MockOutputter.new
    @new_user = BankUi.new(outputter: @mock_outputter, inputter: STDIN, bank_account: BankAccount.new)
    allow_any_instance_of(BankUi).to receive(:sleep).and_return(nil)
  end

  it 'run opens CLI Homepage' do
    allow(STDIN).to receive(:gets).and_return('4')
    @new_user.run_bank_ui
    expect(@mock_outputter.outputs).to eq(["\e[H\e[2J\nWelcome to CLI Bank\n===================", "Please select an option (1/2/3/4) from the list below:\n1. Display Statement\n2. Deposit Money\n3. Withdraw Money\n4. Exit Application", "\e[H\e[2J", 'Program exitting...'])
  end
  it 'allows a user to deposit and withdraw money, then see statement' do
    allow(STDIN).to receive(:gets).and_return('2', '100', '3', '112', '1', '4')
    allow(STDIN).to receive(:getc).and_return('1')
    @new_user.run_bank_ui
    expect(@mock_outputter.outputs).to eq(["\e[H\e[2J\nWelcome to CLI Bank\n===================", "Please select an option (1/2/3/4) from the list below:\n1. Display Statement\n2. Deposit Money\n3. Withdraw Money\n4. Exit Application", "\e[H\e[2J", "Deposit Money\n===================", "\nPlease enter amount to deposit (e.g 110.53) or 'quit' to return to user options...", "\e[H\e[2J\nWelcome to CLI Bank\n===================", "Please select an option (1/2/3/4) from the list below:\n1. Display Statement\n2. Deposit Money\n3. Withdraw Money\n4. Exit Application", "\e[H\e[2J", "Withdraw Money\n===================", "\nPlease enter amount to withdraw (e.g 110.53) or 'quit' to return to user options...", "\e[H\e[2J\nWelcome to CLI Bank\n===================", "Please select an option (1/2/3/4) from the list below:\n1. Display Statement\n2. Deposit Money\n3. Withdraw Money\n4. Exit Application", "\e[H\e[2J", "CLI Bank Statement\n===================", "date || credit || debit || balance\n25/02/2020 || || 112.00 || -12.00 \n25/02/2020 || 100.00 || || 100.00 \n", "\nPress any key to return to options...", "\e[H\e[2J\nWelcome to CLI Bank\n===================", "Please select an option (1/2/3/4) from the list below:\n1. Display Statement\n2. Deposit Money\n3. Withdraw Money\n4. Exit Application", "\e[H\e[2J", 'Program exitting...'])
  end
end
