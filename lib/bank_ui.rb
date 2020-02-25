# User interface for CLI Bank, accepts Ouputter, Inputter, and Bank class in initalization
class BankUi
  def initialize(outputter:, inputter:)
    @outputter = outputter
    @inputter = inputter
  end

  def start_banking
    @outputter.puts("\e[H\e[2J")
    @outputter.puts('Welcome to CLI Bank')
  end

  def user_options
    @outputter.puts("\e[H\e[2J")
    @outputter.puts("Please select an option (1/2/3/4) from the list below:\n1. Display Statement\n2. Deposit Money\n3. Withdraw Money\n4. Exit Application")
    @inputter.gets.chomp
  end
end
