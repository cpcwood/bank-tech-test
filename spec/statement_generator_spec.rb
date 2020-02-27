require 'statement_generator'

describe StatementGenerator do
  describe '#create_statement' do
    it 'has method to return statement from a transaction history' do
      expect(subject).to respond_to(:create_statement).with(1).argument
    end
  end
end