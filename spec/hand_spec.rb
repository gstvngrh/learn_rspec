require 'high_card'

describe 'hand rankings', :aggregate_failures do
  matcher :beat do |losing|
    match do |winning|
      HighCard.beats?(hand(winning), hand(losing))
    end

    failure_message do |winning|
      "expected <#{hand(winning).join(" ")}> to beat <#{hand(losing).join(" ")}>"
    end
  end

  def hand(strings)
    strings.map { |x| Card.from_string(x) }
  end

  example 'hand with highest card wins' do
    expect(%w(10H)).to beat(%w(9H))
    expect(%w(9H)).not_to beat(%w(10H))

    expect(%w(6H 9H)).to beat(%w(9H))
    expect(%w(8H 9H)).not_to beat(%w(6H 10H))
  end

  example 'next highest card is used as tie breaker' do
    expect(%w(10H 9H)).to beat (%w(10C 8H))
    expect(%w(10H 10S 9H)).to beat(%w(10C 10D 8H))
  end
end
