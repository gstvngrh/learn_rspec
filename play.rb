$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require 'high_card'

HighCard::CLI.run(*ARGV)
