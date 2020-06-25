require_relative("pieces.rb")

class Board
    attr_reader :grid, :white_pieces, :black_pieces
    def initialize
        @grid = Array.new(8) { Array.new(8) }
        
        @grid[0][0] = Rook.new(true)
        @grid[0][7] = Rook.new(true)
        @grid[0][1] = Knight.new(true)
        @grid[0][6] = Knight.new(true)
        @grid[0][2] = Bishop.new(true)
        @grid[0][5] = Bishop.new(true)
        @grid[0][3] = King.new(true)
        @grid[0][4] = Queen.new(true)
        
        @grid[7][0] = Rook.new(false)
        @grid[7][7] = Rook.new(false)
        @grid[7][1] = Knight.new(false)
        @grid[7][6] = Knight.new(false)
        @grid[7][2] = Bishop.new(false)
        @grid[7][5] = Bishop.new(false)
        @grid[7][3] = King.new(false)
        @grid[7][4] = Queen.new(false)

        (0..1).each do |j| # Pawns
            (0..7).each do |i|
                if j == 0
                    @grid[1][i] = Pawn.new(true)
                else
                    @grid[6][i] = Pawn.new(false)
                end
            end
        end

        (2..5).each do |i| # Nulls
            (0..7).each do |j|
                @grid[i][j] = NullPiece.new
            end
        end
        # key => piece type, val => position
        pawn = @grid[1][0].print_piece
        rook = @grid[0][0].print_piece
        knight = @grid[0][1].print_piece
        bishop = @grid[0][2].print_piece
        queen = @grid[0][3].print_piece
        king = @grid[0][4].print_piece

        @white_pieces = Hash.new() {[]}
        @black_pieces = Hash.new() {[]}

        @white_pieces[pawn] = [[1, 0], [1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7]]
        @white_pieces[rook] = [[0, 0], [0, 7]]
        @white_pieces[knight] = [[0, 1], [0, 6]]
        @white_pieces[bishop] = [[0, 2], [0, 5]]
        @white_pieces[queen] = [[0, 4]]
        @white_pieces[king] = [[0, 3]]

        @black_pieces[pawn] = [6, 0], [6, 1], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6], [6, 7]
        @black_pieces[rook] = [[7, 0], [7, 7]]
        @black_pieces[knight] = [[7, 1], [7, 6]]
        @black_pieces[bishop] = [[7, 2], [7, 5]]
        @black_pieces[queen] = [[7, 4]]
        @black_pieces[king] = [[7, 3]]
    end

    def [](pos)
        @grid[pos[0]][pos[1]]
    end

    def []=(pos, value)
        @grid[pos[0]][pos[0]] = value
    end

    def select_piece(pos) # Display piece information (position and possible moves)
        piece = @grid[pos[0]][pos[1]]
        p piece.potential_moves(pos, @grid)
    end

    def render # print the board
        puts "  0 1 2 3 4 5 6 7"
        (0..7).each do |i|
            str = "#{i} "
            (0..7).each do |j|
                str += @grid[i][j].print_piece + " "
            end
            puts str
        end
    end

    def move_piece(start_pos, end_pos)
        piece = @grid[start_pos[0]][start_pos[1]]
        if piece.color == nil
            p 'invalid color'
            raise 'Invalid Start Pos'
        end

        if start_pos == end_pos
            p 'equal positions'
            raise 'Invalid Input'
        end

        if start_pos[0] < 0 || start_pos[0] > 7 || end_pos[0] < 0 || end_pos[0] > 7 || start_pos[1] < 0 || start_pos[1] > 7 || end_pos[1] < 0 || end_pos[1] > 7
            p 'position not on board'
            raise 'Invalid Input'
        end
        
        if piece.potential_moves(start_pos, @grid).include?(end_pos)
            replaced_piece = @grid[end_pos[0]][end_pos[1]]
            if replaced_piece.color == false
                p replaced_piece.print_piece
                @black_pieces[replaced_piece.print_piece].delete([end_pos[0], end_pos[1]])
                p 'first delete no error'
                @white_pieces[piece.print_piece].delete([start_pos[0], start_pos[1]])
                @white_pieces[piece.print_piece] += [end_pos[0], end_pos[1]]
            elsif replaced_piece.color == true
                @white_pieces[replaced_piece.print_piece].delete([end_pos[0], end_pos[1]])
                @black_pieces[piece.print_piece].delete([start_pos[0], start_pos[1]])
                @black_pieces[piece.print_piece] += [end_pos[0], end_pos[1]]
            end
            @grid[end_pos[0]][end_pos[1]] = piece

            @grid[start_pos[0]][start_pos[1]] = NullPiece.new
        else
            p 'no potential moves match input move'
            raise 'Invalid Move'
        end
    end

end

# i component = top/bottom
# j component = left/right

# b = Board.new
# b.render

# b.select_piece([0, 3])

# i = 1 -- up/down
# j = 2 -- left/right