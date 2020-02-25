require 'bank_ui'

class MockOutputter
  attr_reader :outputs
  def initialize
    @outputs = []
  end

  def puts(output)
    @outputs.push(output)
  end
end

describe BankUi do
  let(:bank_account){ double :bank_account, statement: 'test statement', deposit: nil }
  before(:each) do
    @mock_outputter = MockOutputter.new
    @bank_ui = BankUi.new(outputter: @mock_outputter, inputter: STDIN, bank_account: bank_account)
  end

  describe '#start_banking' do
    it 'clears console before welcoming user' do
      @bank_ui.start_banking
      expect(@mock_outputter.outputs[0]).to eq("\e[H\e[2J")
    end
    it 'welcomes user to banking' do
      @bank_ui.start_banking
      expect(@mock_outputter.outputs[1]).to eq('Welcome to CLI Bank')
    end
  end

  describe '#user_options' do
    it 'clears console before adding options to screen' do
      allow(STDIN).to receive(:gets).and_return('1')
      @bank_ui.user_options
      expect(@mock_outputter.outputs[0]).to eq("\e[H\e[2J")
    end
    it 'displays list of options' do
      allow(STDIN).to receive(:gets).and_return('1')
      @bank_ui.user_options
      expect(@mock_outputter.outputs[1]).to eq("Please select an option (1/2/3/4) from the list below:\n1. Display Statement\n2. Deposit Money\n3. Withdraw Money\n4. Exit Application")
    end
    it 'asks user for input' do
      allow(STDIN).to receive(:gets).and_return('1')
      expect(STDIN).to receive(:gets)
      @bank_ui.user_options
    end
    it 'if user does not input valid input, it asks again' do
      allow(STDIN).to receive(:gets).and_return('6', '3')
      @bank_ui.user_options
      expect(@mock_outputter.outputs[2]).to eq('Incorrect input, please try again...')
    end
    it 'returns user input' do
      allow(STDIN).to receive(:gets).and_return('3')
      expect(@bank_ui.user_options).to eq('3')
    end
  end

  describe '#display_statement' do
    before(:each) do
      allow(STDIN).to receive(:gets).and_return('4')
    end

    it 'clears console before displaying statement' do
      @bank_ui.display_statement
      expect(@mock_outputter.outputs[0]).to eq("\e[H\e[2J")
    end
    it 'adds title to screen' do
      @bank_ui.display_statement
      expect(@mock_outputter.outputs[1]).to eq("CLI Bank Statement\n===================")
    end
    it 'adds displays statement from passed in bank account class' do
      @bank_ui.display_statement
      expect(@mock_outputter.outputs[2]).to eq('test statement')
    end
    it 'asks user to input any charater to return to options' do
      @bank_ui.display_statement
      expect(@mock_outputter.outputs[3]).to eq("\nInput any charater to return to options...")
    end
    it 'requires input before returning' do
      expect(STDIN).to receive(:gets)
      @bank_ui.display_statement
    end
  end

  describe '#deposit_money' do
    before(:each) do
      allow(STDIN).to receive(:gets).and_return('10.20')
    end

    it 'clears console before displaying outputs' do
      @bank_ui.deposit_money
      expect(@mock_outputter.outputs[0]).to eq("\e[H\e[2J")
    end
    it 'adds title to screen' do
      @bank_ui.deposit_money
      expect(@mock_outputter.outputs[1]).to eq("Deposit Money\n===================")
    end
    it 'asks user for input' do
      @bank_ui.deposit_money
      expect(@mock_outputter.outputs[2]).to eq("\nPlease enter amount to deposit (e.g 110.53) or 'quit' to return to user options...")
    end
    it 'gets user input' do
      expect(STDIN).to receive(:gets)
      @bank_ui.deposit_money
    end
    it 'if input is invalid number deposit displays error and returns' do
      allow(STDIN).to receive(:gets).and_return('asd10.00')
      @bank_ui.deposit_money
      expect(@mock_outputter.outputs[3]).to eq("Invalid number or 'quit' inputted, returning to user options")
    end
    it 'if input is valid add to bank account as float' do
      expect(bank_account).to receive(:deposit).with(10.20)
      @bank_ui.deposit_money
    end
  end

  describe '#withdraw money' do
    it 'clears console before displaying outputs' do
      @bank_ui.withdraw_money
      expect(@mock_outputter.outputs[0]).to eq("\e[H\e[2J")
    end
    it 'adds title to screen' do
      @bank_ui.withdraw_money
      expect(@mock_outputter.outputs[1]).to eq("Withdraw Money\n===================")
    end
    it 'asks user for input' do
      @bank_ui.withdraw_money
      expect(@mock_outputter.outputs[2]).to eq("\nPlease enter amount to withdraw (e.g 110.53) or 'quit' to return to user options...")
    end
  end

  describe '#run_bank_ui' do
    it 'runs start banking method' do
      allow(STDIN).to receive(:gets).and_return('4')
      expect(@bank_ui).to receive(:start_banking)
      @bank_ui.run_bank_ui
    end
    it 'asks users for input' do
      allow(STDIN).to receive(:gets).and_return('4')
      expect(@bank_ui).to receive(:user_options)
      @bank_ui.run_bank_ui
    end
    it 'if input is 1, it runs display statement' do
      allow(STDIN).to receive(:gets).and_return('1')
      expect(@bank_ui).to receive(:display_statement).and_return(nil)
      @bank_ui.run_bank_ui
    end
    it 'if input is 2, its runs deposit money' do
      allow(STDIN).to receive(:gets).and_return('2')
      expect(@bank_ui).to receive(:deposit_money).and_return(nil)
      @bank_ui.run_bank_ui
    end
  end
end
