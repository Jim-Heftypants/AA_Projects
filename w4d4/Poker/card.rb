class Card
    attr_reader :value, :suit
    def initialize(value, suit)
        @value = value
        @suit = suit
    end

    def print_card
        suit_print = ""
        case @suit
        when "Hearts"
            suit_print = '❤'
        when "Spades"
            suit_print = "♠"
        when "Clubs"
            suit_print = "♣"
        when "Diamonds"
            suit_print = "♦"
        end
        return @value.to_s + " of " + suit_print
    end


end
