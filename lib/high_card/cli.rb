module HighCard
  class CLI
    def self.default_account
      Banker.new(ENV.fetch('HIGHCARD_DIR', File.expand_path("../../temp/bank-accounts", __FILE__)), 'gustav')
    end

    def self.run(seed = rand(100000), deck: Deck.new, ui: UI.new, account: default_account)
      Kernel.srand seed.to_i

      deck ||= Deck.new

      if !account.exists?
        ui.ui.puts "Could not find bank account, you cannot play"
        return
      end

      hand      = deck.deal(5).sort_by(&:rank).reverse
      opposing  = deck.deal(5).sort_by(&:rank).reverse

      ui.puts  "Your hand is #{hand.join(", ")}"
      start = Time.now
      input = ui.yesno_prompt("Bet $1 to win?")

      if Round.win?(input, hand, opposing)
        ui.puts "You won!"
        account.adjust!(1)
      else
        ui.puts "You lost!"
        account.adjust!(-1)
      end

      ui.puts "Opposing hand was #{opposing.join(", ")}"
      ui.puts "Balance is #{account.balance}"
      ui.puts "You took #{Time.now - start}s to make a decision."
    end
  end

  class UI
    def yesno_prompt(message)
      print message + " Y/N "
      input = $stdin.gets
      input[0].downcase == "n"
    end

    def puts(messages)
      $stdout.puts messages
    end
  end

  class Round
    def self.win?(bet, hand, opposing)
      winning   = [hand, opposing]
        .sort_by { |h| h.map(&:rank).sort.reverse }
        .last

      bet ^ (opposing == winning)
    end
  end

  class Bank
    class Account
      attr_reader :name, :balance

      def initialize(path, name)
        @path     = path
        FileUtils.mkdir_p(path)
        @name     = name
        @balance  = File.read(path+ "/#{name}").to_i rescue 0
      end

      def debit!(account, amount)
        raise if account != name
        @balance -= amount
        write!
      end

      def credit!(account, amount)
        raise if account != name
        @balance += amount
        write!
      end

      private

      def write!
        File.write(@path + "/#{name}", balance)
      end
    end

    def initialize(path)
      @path = path
    end

    def accounts
      [Account.new(@path, "gustav")]
    end
  end
end
