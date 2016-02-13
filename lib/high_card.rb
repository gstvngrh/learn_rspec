require "card"
require "deck"
require "fileutils"

require "high_card/banker"
require "high_card/cli"

module HighCard
  def self.beats?(hand, opposing)
    winning   = [hand, opposing]
      .sort_by { |h| h.map(&:rank).sort.reverse }
      .last
    hand == winning
  end
end
