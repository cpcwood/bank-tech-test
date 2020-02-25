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
  before(:each) do
    @mock_outputter = MockOutputter.new
    @bank_ui = BankUi.new(outputter: @mock_outputter, inputter: STDIN)
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
end
