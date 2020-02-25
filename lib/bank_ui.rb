# User interface for CLI Bank, accepts Ouputter, Inputter, and Bank class in initalization
class BankUi
  def initialize(outputter:, inputter:)
    @outputter = outputter
    @inputter = inputter
  end

  def run_bank_ui
    start_banking
    user_options
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
    @outputter.puts('CLI Bank Statement')
  end
end
