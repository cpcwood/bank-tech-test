# User interface for CLI Bank, accepts Ouputter, Inputter, and Bank class in initalization
class BankUi
  def initialize(outputter:)
    @outputter = outputter
  end

  def start_banking
    @outputter.puts("\e[H\e[2J")
    @outputter.puts('Welcome to CLI Bank')
  end

  def user_options
    @outputter.puts("\e[H\e[2J")
  end
end
