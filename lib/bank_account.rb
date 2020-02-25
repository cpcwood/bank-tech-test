# Bank account class allow user to deposit and withdraw money, and show statment
class BankAccount
  def initialize
    @balance = 0
    @transaction_history = []
  end

  def deposit(amount_being_deposited)
    @balance += amount_being_deposited
    @transaction_history.push({ date: Time.now, credit: amount_being_deposited, balance: @balance })
  end

  def withdraw(amount_being_withdrawn)
    @balance -= amount_being_withdrawn
    @transaction_history.push({ date: Time.now, debit: amount_being_withdrawn, balance: @balance })
  end

  def statement
    statement = "date || credit || debit || balance\n"
    @transaction_history.each do |record|
      statement += generate_statement_line(record)
    end
    statement
  end

  private

  def generate_statement_line(record)
    "#{str_value(record[:date].strftime('%d/%m/%Y'))}||#{str_value(record[:credit])}||#{str_value(record[:debit])}||#{str_value(record[:balance])}\n"
  end

  def str_value(value)
    value ? " #{value} " : ' '
  end
end
