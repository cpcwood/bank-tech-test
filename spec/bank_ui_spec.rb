require 'bank_ui'

describe BankUi do
  describe '#start_banking' do
    it 'Welcomes user to banking' do
      expect(STDOUT).to receive(:puts).with('Welcome to CLI Bank')
      subject.start_banking
    end
  end
end
