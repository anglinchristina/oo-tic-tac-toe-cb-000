class TicTacToe

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5],  # Middle row
    [6,7,8], # Bottom row
    [0,3,6], # First column
    [1,4,7], # Second column
    [2,5,8], # Third column
    [0,4,8], #diagonal
    [2,4,6] #other diagonal
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_pos)
    user_pos = user_pos.to_i
    user_pos = user_pos - 1
  end

  def move(idx, user_char="X")
    @board[idx] = user_char
    return @board
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(real_pos)
    if !position_taken?(real_pos) && real_pos.between?(0, 8)
      true
    elsif position_taken?(real_pos) || !real_pos.between?(0, 8)
      false
    end
  end

  def turn_count
    i = 0
    @board.each do |b|
      if b == "X" || b == "O"
        i += 1
      end
    end
    return i
  end

  def current_player
    c = turn_count
    if c % 2 != 0
      return "O"
    else
      return "X"
    end
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.chomp
    input = input_to_index(input)
    if valid_move?(input)
      user_char = current_player
      move(input, user_char)
      display_board
    else
      turn
    end
  end

  def won?
  	WIN_COMBINATIONS.detect do |combo|
  		@board[combo[0]] == @board[combo[1]] &&
  		@board[combo[1]] == @board[combo[2]] &&
  		position_taken?(combo[0])
  	end
  end

  def full?
    @board.all? { |pos| pos == "X" || pos == "O" }
  end

  def over?
    #returns true if the board has been won, is a draw, or is full.
    if won? || draw? || full?
      true
    end
  end

    def draw?
      if full? && !won?
        true
      else
        false
      end
    end

    def winner
      win_pos = won?
      if win_pos.kind_of?(Array)
        return @board[win_pos[0]]
      else
        return nil
      end
    end

    def play
      until over?
      	turn
      end

      if won?
      	win_player = winner
      	puts "Congratulations #{win_player}!"
      elsif draw?
      	puts "Cat's Game!"
      end
    end


end
