# require 'simpleton'

class Pieces

    attr_accessor :color

    def initialize(color) # pos = [0, 0], color = true
        @color = color
    end

    def print_piece
        # print possible moves
        # print possible end positions
    end

    def potential_moves(start_pos, grid)
       []
    end

    def can_move?(start_pos, end_pos)
 
    end

end

class NullPiece < Pieces
    
    def initialize
        @color = nil
    end

    def print_piece
        return " "
    end

    def potential_moves(start_pos, grid)
        []
    end

    def can_move?()
        return nil
    end

end

class Pawn < Pieces
    
    def initialize(color)
        super(color)
    end

    def print_piece
        return "P"
    end

    def potential_moves(pos, grid) # movement -> linear -- attacks 
        moves_list = []
        
        selected_piece_color = grid[pos[0]][pos[1]].color # white is true, black is false
        if selected_piece_color == false # black pieces
            if pos[0] == 6 # we know this is the first move for black
                moves_list << [pos[0]-1, pos[1]]
                moves_list << [pos[0]-2, pos[1]]
            elsif grid[pos[0]-1][pos[1]].color == nil
                moves_list << [pos[0]-1, pos[1]]
            end

            # need to include special case attack
            if !(pos[1] == 0) # checks if piece is not on the left-most side of the board
                if grid[pos[0]-1][pos[1]-1].color == !(selected_piece_color)
                    moves_list << [pos[0]-1, pos[1]-1]
                end
            end
            if !(pos[1] == 7) # checks if piece is not on the right-most side of the board
                if grid[pos[0]-1][pos[1]+1].color == !(selected_piece_color)
                    moves_list << [pos[0]-1, pos[1]+1]
                end
            end
        end

        if selected_piece_color == true # white pieces
            if pos[0] == 1 # we know this is the first move for whitte
                moves_list << [pos[0]+1, pos[1]]
                moves_list << [pos[0]+2, pos[1]]
            elsif grid[pos[0]+1][pos[1]].color == nil
                moves_list << [pos[0]+1, pos[1]]
            end
            
            # need to include special case attack
            if !(pos[1] == 7) # checks if piece is not on the right-most side of the board
                if grid[pos[0]+1][pos[1]+1].color == !(selected_piece_color)
                    moves_list << [pos[0]+1, pos[1]+1]
                end
            end
            if !(pos[1] == 0) # checks if piece is not on the left-most side of the board
                if grid[pos[0]+1][pos[1]-1].color == !(selected_piece_color)
                    moves_list << [pos[0]+1, pos[1]-1]
                end
            end
        end
        return moves_list
    end

    def can_move?(start_pos, end_pos)
        
    end

end


class King < Pieces
    
    def initialize(color)
        super(color)
    end

    def print_piece
        return "K"
    end

    def potential_moves(start_pos, grid)
        moves_list = []
        
        selected_piece_color = grid[start_pos[0]][start_pos[1]].color
        (start_pos[0]-1..start_pos[0]+1).each do |i|
            (start_pos[1]-1..start_pos[1]+1).each do |j|
                if (i > -1 && i < 8 && j > -1 && j < 8) # (0, 2) pass
                    if !(i == start_pos[0] && j == start_pos[1]) # checks the space that king is on. # (0, 2) fail
                        if (selected_piece_color != grid[i][j].color) || (grid[i][j].color == nil)
                            moves_list << [i, j]
                        end
                    end
                end
            end
        end
        moves_list
    end

    def can_move?(start_pos, end_pos)       # board
        xChange = end_pos[0] - start_pos[0]
        if xChange < 0
            xChange = -xChange
        end
        yChange = end_pos[1] - start_pos[1]
        if yChange < 0
            yChange = -yChange
        end
        return !(yChange > 1 || xChange > 1)
    end
    
end

def potential_moves_diagonal(start_pos, grid)
    moves_list = []

    piece_color = grid[start_pos[0]][start_pos[1]]
    
    i = start_pos[0] + 1; j = start_pos[1] - 1          # middle => top left
    while i < 8 && j > -1 && grid[i][j].color == nil
        moves_list << [i, j]
        i += 1; j -= 1
    end

    # i += 1; j -= 1
    if i < 8 && j > -1
        if grid[i][j].color == !(piece_color)
            moves_list << [i, j]
        end
    end

    i = start_pos[0] - 1; j = start_pos[1] + 1          # middle => bottom right
    while i > -1 && j < 8 && grid[i][j].color == nil
        moves_list << [i, j]
        i += 1; j -= 1
    end

    # i -= 1; j += 1
    if i > -1 && j < 8
        if grid[i][j].color == !(piece_color)
            moves_list << [i, j]
        end
    end
    
    i = start_pos[0] - 1; j = start_pos[1] - 1          # middle => bottom left
    while i > -1 && j > -1 && grid[i][j].color == nil
        moves_list << [i, j]
        i -= 1; j -= 1
    end

    # i -= 1; j -= 1
    if i > -1 && j > -1
        if grid[i][j].color == !(piece_color)
            moves_list << [i, j]
        end
    end

    i = start_pos[0] + 1; j = start_pos[1] + 1          # middle => top right
    while i < 8 && j < 8 && grid[i][j].color == nil
        moves_list << [i, j]
        i += 1; j += 1
    end

    # i += 1; j += 1
    if i < 8 && j < 8
        if grid[i][j].color == !(piece_color)
            moves_list << [i, j]
        end
    end

    moves_list
end

def potential_moves_rectangular(start_pos, grid)
    moves_list = []

    piece_color = grid[start_pos[0]][start_pos[1]].color

    anchorX = start_pos[1] # left/right -- 4
    anchorY = start_pos[0] # up/down ----- 3
    
    yFloor = anchorY - 1
    while yFloor > -1 && grid[yFloor][anchorY].color == nil # center => top
        moves_list << [yFloor, anchorX]
        yFloor -= 1
    end

    # yFloor -= 1
    if yFloor > -1
        if grid[yFloor][anchorY].color == !(piece_color)
            moves_list << [yFloor, anchorX]
        end
    end

    yCeiling = anchorY + 1
    while yCeiling < 8 && grid[yCeiling][anchorY].color == nil # center => bottom
        moves_list << [yCeiling, anchorX]
        yCeiling += 1
    end
    
    # yCeiling += 1
    if yCeiling < 8
        if grid[yCeiling][anchorY].color == !(piece_color)
            moves_list << [yCeiling, anchorX]
        end
    end

    
    xFloor = anchorX - 1
    while xFloor > -1 && grid[anchorY][xFloor].color == nil # center => left
        moves_list << [anchorY, xFloor]
        xFloor -= 1
    end
    
    # xFloor -= 1
    if xFloor > -1
        if grid[anchorY][xFloor].color == !(piece_color)
            moves_list << [anchorY, xFloor]
        end
    end
    
    xCeiling = anchorX + 1
    while xCeiling < 8 && grid[anchorY][xCeiling].color == nil #center => right
        moves_list << [anchorY, xCeiling]
        xCeiling += 1
    end

    # xCeiling += 1
    if xCeiling < 8
        if grid[anchorY][xCeiling].color == !(piece_color)
            moves_list << [anchorY, xCeiling]
        end
    end

    moves_list
end

class Queen < Pieces
    
    def initialize(color)
        super(color)
    end

    def print_piece
        return "Q"
    end
    
    def potential_moves(start_pos, grid)
        # p grid[start_pos[0]][start_pos[1]].print_piece
        potential_moves_rectangular(start_pos, grid) + potential_moves_diagonal(start_pos, grid)
    end

    def can_move?(start_pos, end_pos)
        
    end
    
end



class Bishop < Pieces

    def initialize(color)
        super(color)
    end

    def print_piece
        return "B"
    end

    def potential_moves(start_pos, grid)
        potential_moves_diagonal(start_pos, grid)
    end

    def can_move?(start_pos, end_pos)
        
    end
end

class Knight < Pieces

    def initialize(color)
        super(color)
    end

    def print_piece
        return "H"
    end

    def potential_moves(start_pos, grid)
        moves_list = []
        moves_list << [start_pos[0] + 2, start_pos[1] + 1]
        moves_list << [start_pos[0] + 1, start_pos[1] + 2]
        moves_list << [start_pos[0] - 2, start_pos[1] + 1]
        moves_list << [start_pos[0] - 1, start_pos[1] + 2]
        moves_list << [start_pos[0] - 2, start_pos[1] - 1]
        moves_list << [start_pos[0] - 1, start_pos[1] - 2]
        moves_list << [start_pos[0] + 2, start_pos[1] - 1]
        moves_list << [start_pos[0] + 1, start_pos[1] - 2]
        piece_color = grid[start_pos[0]][start_pos[1]].color
        i = 0
        while i < moves_list.length
            if (moves_list[i][0] < 0 || moves_list[i][0] > 7 || moves_list[i][1] < 0 || moves_list[i][1] > 7) || (grid[moves_list[i][0]][moves_list[i][1]].color == piece_color)
                moves_list.delete_at(i)
                i -= 1
            end
            i += 1
        end
        moves_list
    end
    
    def can_move?(start_pos, end_pos)
        
    end
    
end

class Rook < Pieces

    def initialize(color)
        super(color)
    end

    def print_piece
        return "R"
    end

    def potential_moves(start_pos, grid)
        potential_moves_rectangular(start_pos, grid)
    end

    def can_move?(start_pos, end_pos)
        
    end
    
end