class StatementGenerator
  def create_statement(transaction_history)
    statement = "date || credit || debit || balance\n"
    transaction_history.each do |record|
      statement += generate_statement_line(record)
    end
    statement
  end

  private

  def generate_statement_line(record)
    "#{record[:date].strftime('%d/%m/%Y')} ||#{str_value(record[:credit])}||#{str_value(record[:debit])}||#{str_value(record[:balance])}\n"
  end

  def str_value(value)
    value ? " #{format('%<value>.2f', value: value)} " : ' '
  end

end