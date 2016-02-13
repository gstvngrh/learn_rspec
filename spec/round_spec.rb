require "high_card"

describe 'Round' do
  def win?(*args)
    HighCard::Round.win?(*args)
  end

  let(:stronger_hand) { [Card.build(:hearts, 9)] }
  let(:weaker_hand) { [Card.build(:hearts, 8)] }

  describe ".win?" do
    specify "betting on stronger hand wins" do
      expect(win?(true, stronger_hand, weaker_hand)).to eq(true)
    end

    specify "betting on weaker hand loses" do
      expect(win?(true, weaker_hand, stronger_hand)).to eq(false)
    end

    specify "not betting on stronger hand loses" do
      expect(win?(false, stronger_hand, weaker_hand)).to eq(false)
    end

    specify "not betting on weaker hand wins" do
      expect(win?(false, weaker_hand, stronger_hand)).to eq(true)
    end
  end
end
