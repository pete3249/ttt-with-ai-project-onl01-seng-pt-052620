require 'pry'

class Game
    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
      ]
    
    attr_accessor :board, :player_1, :player_2
      
    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = board
    end 

    def current_player
        if self.board.cells.count { |space| space == "X" || space == "O"}.even?
            self.player_1
        else 
            self.player_2
        end   
    end 

    def won?
        WIN_COMBINATIONS.detect do |winning_combo|
            @board.cells[winning_combo[0]] == @board.cells[winning_combo[1]] && 
            @board.cells[winning_combo[1]] ==  @board.cells[winning_combo[2]] &&
            (@board.cells[winning_combo[0]] == "X" || @board.cells[winning_combo[0]] == "O")
        end 
    end 

   def draw?
        if !won? && @board.full?
            return true 
        else 
            return false
        end
    end 

    def over?
        if won? || draw?
            return true
        else
            return false
        end 
    end 

    def winner
        array = won?
        if array
            @winner = @board.cells[array[0]]
        end 
    end 

    def turn
        player_now = current_player
        current_move = player_now.move(@board)
        if @board.valid_move?(current_move)
            @board.update(current_move, player_now)
            @board.display
        else
            puts "Invalid"
            turn
        end 
    end 
  

end 


#     index = input_to_index(user_input)
#       if valid_move?(index) == true
#         letter = current_player
#         move(index, letter)
#         display_board
#       else 
#         turn
#       end 
#   end 



#       game = Game.new
#       allow($stdout).to receive(:puts)

#       expect(game.player_1).to receive(:gets).and_return("1")

#       game.turn
#     end

#     it 'asks for input again after a failed validation' do
#       game = Game.new
#       allow($stdout).to receive(:puts)

#       expect(game.player_1).to receive(:gets).and_return("invalid")
#       expect(game.player_1).to receive(:gets).and_return("1")

#       game.turn
#     end

#     it 'changes to player 2 after the first turn' do
#       game = Game.new
#       allow($stdout).to receive(:puts)

#       expect(game.player_1).to receive(:gets).and_return("1")
#       expect(game.player_2).to receive(:gets).and_return("2")

#       game.turn
#       game.turn
#     end
#   end