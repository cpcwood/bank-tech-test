require 'bank_account'

describe BankAccount do
  describe '#deposit' do
    it 'allows amount of money can be deposited' do
      expect(subject).to respond_to(:deposit).with(1).argument
    end
  end

  describe '#withdraw' do
    it 'allows amount of money to be withdrawn' do
      expect(subject).to respond_to(:withdraw).with(1).argument
    end
  end
end
