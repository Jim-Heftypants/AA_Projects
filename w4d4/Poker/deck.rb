require_relative "card.rb"

class Deck
    attr_accessor :deck
    def initialize
        @deck = []
        suit_types = ["Hearts", "Clubs", "Spades", "Diamonds"]
        values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14] # J => 11... A => 14
        values.each do |value|
            suit_types.each do |suit|
                @deck << Card.new(value, suit)
            end
        end
    end

    def remove_card(card)
        @deck.delete(card)
    end



end