require 'bank_ui'

describe BankUi do
  describe '#start_banking' do
    it 'Welcomes user to banking' do
      expect(subject).to receive(:print_output).with('Welcome to CLI Bank')
      subject.start_banking
    end
  end

  describe '#print_output' do
    it 'Prints argument to the console' do
      expect(STDOUT).to receive(:puts).with('test')
      subject.print_output('test')
    end
  end
end
