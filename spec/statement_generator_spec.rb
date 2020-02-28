require 'statement_generator'

describe StatementGenerator do

  describe '#create_statement' do
    it 'has method to return statement from a transaction history' do
      expect(subject).to respond_to(:create_statement).with(1).argument
    end
    it 'displays header of (date, credit, debit, balance) on top line' do
      transaction_history = []
      top_line = subject.create_statement(transaction_history).split("\n")[0]
      expect(top_line).to eq("date || credit || debit || balance")
    end
    it 'prints credit statement' do
      transaction_history = [{ date: Time.new(2012, 1, 10), credit: 92.12, balance:  92.12}]
      result = subject.create_statement(transaction_history).split("\n")
      expect(result[1]).to include('10/01/2012 || 92.12 || || 92.12')
    end
    it 'prints debit statement' do
      transaction_history = [{ date: Time.new(2012, 1, 10), debit: 92.12, balance:  -92.12}]
      result = subject.create_statement(transaction_history).split("\n")
      expect(result[1]).to include('10/01/2012 || || 92.12 || -92.12')
    end
    it 'prints multiple transactions in reverse chronological order' do
      transaction_history = [{ date: Time.new(2012, 1, 10), credit: 92.12, balance:  92.12},
        { date: Time.new(2012, 1, 14), debit: 120, balance: -27.79 }]
      result = subject.create_statement(transaction_history).split("\n")
      expect(result[2]).to include('10/01/2012 || 92.12 || || 92.12')
      expect(result[1]).to include('14/01/2012 || || 120.00 || -27.79')
    end
  end
end