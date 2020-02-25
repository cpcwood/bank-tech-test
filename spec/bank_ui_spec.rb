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

mock_outputter = MockOutputter.new

describe BankUi do
  subject{ BankUi.new(outputter: mock_outputter) }

  describe '#start_banking' do
    it 'clears console before welcoming user' do
      subject.start_banking
      expect(mock_outputter.outputs[0]).to eq("\e[H\e[2J")
    end
    it 'welcomes user to banking' do
      subject.start_banking
      expect(mock_outputter.outputs[1]).to eq('Welcome to CLI Bank')
    end
  end
end
