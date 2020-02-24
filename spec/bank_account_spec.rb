require 'bank_account'

describe BankAccount do
  describe '#deposit' do
    it 'money can be deposited' do
      expect(subject).to respond_to(:deposit).with(1).argument
    end
  end
end
