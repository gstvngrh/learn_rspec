class Card
  def self.build(suit, rank)
    new(suit: suit, rank: rank)
  end
  private_class_method :new

  def initialize(suit:, rank:)
    @suit = suit
    @rank = case rank
    when :jack then 11
    when :queen then 12
    when :king then 13
    when :ace then 14
    else rank
    end
  end

  def suit
    @suit
  end

  def rank
    @rank
  end

  def ==(other)
    rank == other.rank && suit == other.suit
  end

  def hash
    [rank, suit].hash
  end

  def eql?(other)
    self == other
  end

  def to_s
    id = if rank > 10
      {
        11 => 'J',
        12 => 'Q',
        13 => 'K',
        14 => "A"
      }.fetch(rank)
    else
      rank.to_s
    end

    s = {
      hearts:   "♥ ",
      spades:   "♠ ",
      diamonds: "♦ ",
      clubs:    "♣ ",
    }

    "#{id.upcase}#{s.fetch(suit)}"
  end

  def self.from_string(value)
    short_suit = value[-1]

    suit = {
      "H" => :hearts,
      "D" => :diamonds,
      "S" => :spades,
      "C" => :clubs
    }.fetch(short_suit)

    rank = {
      'A' => :ace,
      'K' => :king,
      'Q' => :queen,
      'J' => :jack
    }.fetch(value[0]) { value[0..-2].to_i }

    Card.build(suit, rank)
  end
end
