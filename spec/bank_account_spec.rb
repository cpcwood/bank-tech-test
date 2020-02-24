require 'bank_account'

describe BankAccount do
  describe '#deposit' do
    it 'allows amount of money can be deposited' do
      expect(subject).to respond_to(:deposit).with(1).argument
    end
    it 'adds deposited sum to the balance' do
      subject.deposit(20)
      expect(subject.statement).to include('20')
    end
  end

  describe '#withdraw' do
    it 'allows amount of money to be withdrawn' do
      expect(subject).to respond_to(:withdraw).with(1).argument
    end
    it 'returns amount of money being withdrawn' do
      expect(subject.withdraw(10)).to eq(10)
    end
    it 'reduces the account balance by the amount being withdrawn' do
      subject.deposit(10)
      subject.withdraw(5)
      expect(subject.statement).to include('5')
    end
  end

  describe '#statment' do
    it 'has method to return statement' do
      expect(subject).to respond_to(:statement)
    end
    it 'returns the current balance of the account' do
      expect(subject.statement).to include('0')
    end
    it 'displays header of balance on top line' do
      top_line = subject.statement.split("\n")[0]
      expect(top_line).to include('balance')
    end
  end
end
