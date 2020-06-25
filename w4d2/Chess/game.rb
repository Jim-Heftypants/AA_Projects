require_relative("pieces.rb")
require_relative("board.rb")

class Game

    def initialize
        @board = Board.new
        @player1 = "White"
        @player2 = "Black"
        @white_pieces = @board.white_pieces
        @black_pieces = @board.black_pieces
        @current_player = @player1
    end
    
    
    def get_piece
        begin
            p 'Enter the position to select a piece and display its potential moves: '
            input = gets.chomp.split(" ").map {|char| char.to_i}
            # check for invalid inputs
            @board.select_piece(input)
            get_move(input)
        rescue
            p 'Invalid entry'
            retry
        end
    end

    def get_move(pos)
        begin
            p "Enter a move or enter -1 to return"
            input = gets.chomp.split(" ").map {|char| char.to_i}
            p input
            if input[0] == -1
                return
            end
            @board.move_piece(pos, input)
            switch_turn
        rescue
            p 'Invalid entry'
            retry
        end
    end

    def switch_turn
        if @current_player == @player1
            @current_player = @player2
        else
            @current_player = @player1
        end
        puts "#{@current_player}'s turn: "
    end

    def play
        until check_mate?
            @board.render
            get_piece
        end
        switch_turn
        p "#{current_player} wins!"
    end

    def check_king?(king_pos)
        if @current_player == "White"
            @black_pieces.each do |name, positions|
                positions.each do |position|
                    return true if @board.grid[position[0]][position[1]].potential_moves(position, @board.grid).include?(king_pos)
                end
            end
            return false
        else
            @white_pieces.each do |name, positions|
                positions.each do |position|
                    return true if @board.grid[position[0]][position[1]].potential_moves(position, @board.grid).include?(king_pos)
                end
            end
            return false
        end
        return nil
    end

    def check_mate?
        if @current_player == "White"
            king_pos = @white_pieces["K"].flatten
            king = @board.grid[king_pos[0]][king_pos[1]]
            if check_king?(king_pos)
                king_moves = king.potential_moves(king_pos, @board.grid)
                king_moves = king_moves.select { |move| !check_king?(move) } > 0 # if king cannot move to a "safe" spot

                if king_moves.empty? # if no pieces can block the check
                    return true
                end
            end
        else
            king_pos = @black_pieces["K"].flatten
            king = @board.grid[king_pos[0]][king_pos[1]]
            if check_king?(king_pos)
                king_moves = king.potential_moves(king_pos, @board.grid)
                king_moves = king_moves.select { |move| !check_king?(move) } > 0 # if king cannot move to a "safe" spot

                if king_moves.empty? # if no pieces can block the check
                    return true
                end
            end
        end
    end

end

g = Game.new
g.play

