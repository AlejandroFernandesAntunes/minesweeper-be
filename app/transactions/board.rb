class Board < BaseTransaction
  tee :params
  step :bombs_by_difficulty
  step :fill_and_bombit
  step :structure_board

  def params(input)
    @rows = input.dig(:params, :rows)
    @cols = input.dig(:params, :cols)
    @difficulty = input.dig(:params, :difficulty) || 5
    @total_rows = @rows * @cols
  end

  def bombs_by_difficulty
    amount_of_bombs = case @difficulty
                      when 0..3
                        (@total_rows * 0.25).to_i
                      when 3..7
                        (@total_rows * 0.50).to_i
                      else
                        (@total_rows * 0.75).to_i
                      end

    Success({ amount_of_bombs: amount_of_bombs })
  end

  def fill_and_bombit(input)
    amount_of_bombs = input.fetch(:amount_of_bombs)
    flat_board = []

    (@total_rows - amount_of_bombs).times { flat_board << 0 }
    amount_of_bombs.times { flat_board << -1 }
    Success({ flat_board: flat_board })
  end

  def structure_board(input)
    flat_board = input.fetch(:flat_board)
    hash_board = {}
    flat_board.shuffle.each_slice(@cols).each_with_index do |filled_row, index|
      hash_board[index] = filled_row
    end
    Success hash_board
  end
end
