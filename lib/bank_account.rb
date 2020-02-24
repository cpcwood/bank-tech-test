# Bank account class allow user to deposit and withdraw money, and show statment
class BankAccount
  def initialize
    @balance = 0
  end

  def deposit(amount_being_deposited)
    @balance += amount_being_deposited
  end

  def withdraw(amount_being_withdrawn)
    @balance -= amount_being_withdrawn
    amount_being_withdrawn
  end

  def statement
    top_line = "balance\n"
    balance = @balance.to_s
    top_line + balance
  end
end
