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
      expect(subject.statement).to include('10.00 || -10.00')
    end
    it 'returns history of debits with associated balance, two decimal places' do
      subject.withdraw(10.12)
      expect(subject.statement).to include('10.12 || -10.12')
    end
    it 'returns history of multiple debits, each on a newline, in reverse order' do
      subject.withdraw(10)
      subject.withdraw(2)
      split_lines = subject.statement.split("\n")
      expect(split_lines[1]).to include('2.00 || -12.00')
      expect(split_lines[2]).to include('10.00 || -10.00')
    end
    it 'displays header with credits title on the top line' do
      top_line = subject.statement.split("\n")[0]
      expect(top_line).to include('credit || debit || balance')
    end
    it 'returns history of credits with associated balance' do
      subject.deposit(10)
      expect(subject.statement).to include('10.00 || || 10.00')
    end
    it 'returns history of multiple credits, each on a newline, in reverse order' do
      subject.deposit(10)
      subject.deposit(2)
      split_lines = subject.statement.split("\n")
      expect(split_lines[1]).to include('2.00 || || 12.00')
      expect(split_lines[2]).to include('10.00 || || 10.00')
    end
    it 'returns history of both credits and debits each on a newline' do
      subject.deposit(10)
      subject.withdraw(15)
      split_lines = subject.statement.split("\n")
      expect(split_lines[1]).to include('|| 15.00 || -5.00')
      expect(split_lines[2]).to include('10.00 || || 10.00')
    end
    it 'displays header with date title on the top line' do
      top_line = subject.statement.split("\n")[0]
      expect(top_line).to include('date || credit || debit || balance')
    end
    it 'returns debit history with data of transaction' do
      allow(Time).to receive(:now).and_return(Time.new(2020, 1, 14))
      subject.deposit(10)
      expect(subject.statement).to include('14/01/2020 || 10.00 || || 10.00')
    end
    it 'returns credit history with data of transaction' do
      allow(Time).to receive(:now).and_return(Time.new(2020, 1, 14))
      subject.withdraw(6)
      expect(subject.statement).to include('14/01/2020 || || 6.00 || -6.00')
    end
    it 'returns both credit and debit history with dates' do
      allow(Time).to receive(:now).and_return(Time.new(2012, 1, 10))
      subject.deposit(1000)
      allow(Time).to receive(:now).and_return(Time.new(2012, 1, 13))
      subject.deposit(2000)
      allow(Time).to receive(:now).and_return(Time.new(2012, 1, 14))
      subject.withdraw(500)
      expect(subject.statement).to eq("date || credit || debit || balance\n14/01/2012 || || 500.00 || 2500.00 \n13/01/2012 || 2000.00 || || 3000.00 \n10/01/2012 || 1000.00 || || 1000.00 \n")
    end
  end
end
