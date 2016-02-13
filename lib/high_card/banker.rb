module HighCard
  class Banker
    def initialize(path, login)
      @bank = Bank.new(path)
      @login = login
      @account = @bank.accounts.detect{ |x| x.name == login }
    end
    
    def adjust!(amount)
      amount >= 0 ? @account.credit!(@login, amount) : @account.debit!(@login, -amount)
    end

    def exists?
      @account
    end

    def balance
      @account.balance
    end
  end
end
