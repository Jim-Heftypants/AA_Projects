require_relative "deck.rb"
require_relative "player.rb"

class Game

    def initialize(num_players)
        @deck = Deck.new
        @deck.deck = @deck.deck.shuffle
        @players = []
        (0...num_players).each do |i|
            p 'Enter player name: '
            name = gets.chomp
            @players << Player.new(@deck, name)
            (0..4).each do |i|
                @deck.deck.shift
            end
        end
    end

    def play
        @deck.deck = @deck.deck.shuffle

        @players.each do |player|
            begin
                p "#{player.name}\'s turn: "
                player.get_turn(@deck)
                p "#{player.name}\'s hand: "
                player.show_hand
            rescue
                p 'Invalid input. Try again'
                retry
            end
        end

        best_hand = @players[0].rank_hand
        winner = @players[0]
        @players.each do |player|
            current_hand = player.rank_hand
            if current_hand[0] > best_hand[0]
                best_hand = current_hand
                winner = player
            elsif current_hand[0] == best_hand[0]
                if current_hand[1] > best_hand[1]
                    best_hand = current_hand
                    winner = player
                end
            end
        end
        p "The winner is #{winner.name}"
        @players.each do |player|
            p "#{player.name}\'s hand: "
            player.show_hand
        end
    end
end

g = Game.new(2)
g.play