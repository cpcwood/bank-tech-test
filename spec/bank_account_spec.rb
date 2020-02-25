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

  describe '#statement' do
    it 'has method to return statement' do
      expect(subject).to respond_to(:statement)
    end
    it 'displays header of balance on top line' do
      top_line = subject.statement.split("\n")[0]
      expect(top_line).to include('balance')
    end
    it 'displays header with debits title on the top line' do
      top_line = subject.statement.split("\n")[0]
      expect(top_line).to include('debit || balance')
    end
    it 'returns history of debits with associated balance' do
      subject.withdraw(10)
      expect(subject.statement).to include('10 || -10')
    end
    it 'returns history of multiple debits each on a newline' do
      subject.withdraw(10)
      subject.withdraw(2)
      split_lines = subject.statement.split("\n")
      expect(split_lines[1]).to include('10 || -10')
      expect(split_lines[2]).to include('2 || -12')
    end
    it 'displays header with credits title on the top line' do
      top_line = subject.statement.split("\n")[0]
      expect(top_line).to include('credit || debit || balance')
    end
    it 'returns history of credits with associated balance' do
      subject.deposit(10)
      expect(subject.statement).to include('10 || || 10')
    end
    it 'returns history of multiple credits each on a newline' do
      subject.deposit(10)
      subject.deposit(2)
      split_lines = subject.statement.split("\n")
      expect(split_lines[1]).to include('10 || || 10')
      expect(split_lines[2]).to include('2 || || 12')
    end
    it 'returns history of both credits and debits each on a newline' do
      subject.deposit(10)
      subject.withdraw(15)
      split_lines = subject.statement.split("\n")
      expect(split_lines[1]).to include('10 || || 10')
      expect(split_lines[2]).to include('|| 15 || -5')
    end
    it 'displays header with date title on the top line' do
      top_line = subject.statement.split("\n")[0]
      expect(top_line).to include('date || credit || debit || balance')
    end
  end
end
