require 'deck'

module ArrayMatchers
  extend RSpec::Matchers::DSL
  # RSpec::Matchers.define(:be_contiguous_by) do
  matcher :be_contiguous_by do
    match do |array|
      # array
      #   .sort
      #   .each_cons(2)
      #   .all? { |x, y| x + 1 == y }
      !first_non_contiguous_pair(array)
    end

    failure_message do |array|
      "%s and %s were not contiguous" % first_non_contiguous_pair(array)
    end

    def first_non_contiguous_pair(array)
      array
        .sort_by(&block_arg)
        .each_cons(2)
        .detect { |x, y| block_arg.call(x) + 1 != block_arg.call(y) }
    end
  end
end

describe 'Deck' do
  include ArrayMatchers
  describe '.all' do
    it 'contains 32 cards' do
      expect(Deck.all.length).to eq(32)
    end

    it 'has a seven as its lowest card' do
      # expect(Deck.all.map { |card| card.rank }).to all(be >= 7)
      expect(Deck.all).to all(have_attributes(rank: be >= 7))
    end

    it 'has contiguous ranks by suit' do
      # expect(Deck.all.group_by(&:suit).values).to be be_contiguous_by(&:rank)
      expect(Deck.all.group_by(&:suit).values).to all(be_contiguous_by(&:rank))
    end
  end
end
