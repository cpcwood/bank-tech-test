# User interface for CLI Bank, accepts Ouputter, Inputter, and Bank class in initalization
class BankUi
  def initialize(outputter:, inputter:, bank_account:)
    @outputter = outputter
    @inputter = inputter
    @bank_account = bank_account
  end

  def run_bank_ui
    start_banking
    loop do
      user_input = user_options
      case user_input
      when '1'
        display_statement
      when '2'
        deposit_money
      when '3'
        withdraw_money
      when '4'
        @outputter.puts('Program exitting...')
        break
      end
    end
  end

  def start_banking
    @outputter.puts("\e[H\e[2J")
    @outputter.puts('Welcome to CLI Bank')
  end

  def user_options
    @outputter.puts("\e[H\e[2J")
    @outputter.puts("Please select an option (1/2/3/4) from the list below:\n1. Display Statement\n2. Deposit Money\n3. Withdraw Money\n4. Exit Application")
    loop do
      user_input = @inputter.gets.chomp
      return user_input if user_input.match?(/1|2|3|4/)
      @outputter.puts('Incorrect input, please try again...')
    end
  end

  def display_statement
    @outputter.puts("\e[H\e[2J")
    @outputter.puts("CLI Bank Statement\n===================")
    @outputter.puts(@bank_account.statement)
    @outputter.puts("\nPress any key to return to options...")
    @inputter.getc
  end

  def deposit_money
    @outputter.puts("\e[H\e[2J")
    @outputter.puts("Deposit Money\n===================")
    @outputter.puts("\nPlease enter amount to deposit (e.g 110.53) or 'quit' to return to user options...")
    input = @inputter.gets.chomp
    return if invalid_input?(input)
    @bank_account.deposit(input.to_f)
  end

  def withdraw_money
    @outputter.puts("\e[H\e[2J")
    @outputter.puts("Withdraw Money\n===================")
    @outputter.puts("\nPlease enter amount to withdraw (e.g 110.53) or 'quit' to return to user options...")
    input = @inputter.gets.chomp
    return if invalid_input?(input)
    @bank_account.withdraw(input.to_f)
  end

  private

  def invalid_input?(input)
    return if input.match?(/\A\d+(\.\d{2})?\z/)
    @outputter.puts("Invalid number or 'quit' inputted, returning to user options")
    true
  end
end
