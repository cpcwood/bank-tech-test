# User interface for CLI Bank, accepts Bank class in initalization as backend logic
class BankUi
  def start_banking
    print_output('Welcome to CLI Bank')
  end
  
  def print_output(output)
    STDOUT.puts(output)
  end
end