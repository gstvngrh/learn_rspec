require 'high_card'

describe 'HighCard::Banker' do
  specify 'adjust changes balance' do
    Dir.mktmpdir do |dir|
      account = HighCard::Banker.new(dir, 'gustav')
      expect(account.balance).to eq(0)
      account.adjust!(1)
      expect(account.balance).to eq(1)
      account.adjust!(-2)
      expect(account.balance).to eq(-1)
    end
  end
end
