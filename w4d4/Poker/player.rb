require_relative 'card.rb'

class Player
    attr_reader :hand, :name
    def initialize(deck, name)
        @name = name
        @hand = []
        (0..4).each do |i|
            @hand << deck.deck[i] # maybe problem
        end
    end

    def get_turn(deck)
        show_hand
        p 'Enter indexs of cards to replace seperated by spaces: '
        p 'Enter -1 to indicate no replacements'
        input = gets.chomp.split(" ").map {|thing| thing.to_i}
        return if input == -1
        input.each do |index|
            raise 'invalid input' if index < 0 || index > 4
        end

        input.each do |index|
            raise 'invalid input' if index < 0 || index > 4
            @hand[index] = deck.deck.shift # maybe problem
        end
    end

    def show_hand
        str = ""
         @hand.each do |card|
            str += card.print_card + ', '
         end
         str[str.length - 2] = ""
         puts str
    end

    def rank_hand
        hash = Hash.new(0)
        @hand.each do |card|
            hash[card] += 1
        end

        hand_value = 1
        card_value = 0
        hash.each do |card, num_appearances|
            case num_appearances
            when 1
                if hand_value == 1
                    card_value = card.value if card_value < card.value
                end
            when 2
                if hand_value == 4
                    hand_value = 7
                elsif hand_value == 2
                    hand_value = 3
                else
                    hand_value = 2
                end
                card_value = card.value
            when 3
                if hand_value == 2
                    hand_value = 7
                else
                    hand_value = 4
                end
                card_value = card.value
            when 4
                hand_value = 8
                card_value = card.value
            end
        end

        if hash.keys.length == 5
            @hand.sort_by { |card| card.value }
            min_card_val = @hand[0].value - 1
            common_suit = @hand[0].suit
            is_straight = true
            is_flush = true
            is_royal = (10..14).include?(@hand[0])
            @hand.each.with_index do |card, i|
                is_flush = false if card.suit != common_suit
                is_straight = false if min_card_val + 1 + i != card.value
            end

            if is_flush && is_straight && is_royal
                hand_value = 12
            elsif is_flush && is_royal
                hand_value = 11
                card_value = @hand[0].value
            elsif is_straight && is_flush
                hand_value = 10
            elsif is_flush
                hand_value = 6
            elsif is_straight
                hand_value = 5
            end
        end

        return [hand_value, card_value]
    end

end