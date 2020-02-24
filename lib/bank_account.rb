# Bank account class allow user to deposit and withdraw money, and show statment
class BankAccount
  def initialize
    @balance = 0
    @transaction_history = []
  end

  def deposit(amount_being_deposited)
    @balance += amount_being_deposited
    @transaction_history.push({ credit: amount_being_deposited, balance: @balance })
  end

  def withdraw(amount_being_withdrawn)
    @balance -= amount_being_withdrawn
    @transaction_history.push({ debit: amount_being_withdrawn, balance: @balance })
    amount_being_withdrawn
  end

  def statement
    statement = "credit || debit || balance\n"
    @transaction_history.each do |record|
      statement += generate_statement_line(record)
    end
    statement
  end

  private

  def generate_statement_line(record)
    "#{stringify_value(record[:credit])}||#{stringify_value(record[:debit])}||#{stringify_value(record[:balance])}\n"
  end

  def stringify_value(value)
    value ? " #{value} " : ' '
  end
end
