require 'statement_generator'

describe StatementGenerator do
  transaction_history = [{ date: Time.new(2012, 1, 10), credit: 92.12, balance: @balance },
    { date: Time.new(2012, 1, 14), credit: 120, balance: @balance }]

  describe '#create_statement' do
    it 'has method to return statement from a transaction history' do
      expect(subject).to respond_to(:create_statement).with(1).argument
    end
    it 'displays header of (date, credit, debit, balance) on top line' do
      top_line = subject.create_statement(transaction_history).split("\n")[0]
      expect(top_line).to eq("date || credit || debit || balance")
    end
  end
end