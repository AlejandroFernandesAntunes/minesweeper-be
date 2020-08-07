module Types
  class QueryType < Types::BaseObject
    field :fetch_board, GraphQL::Types::JSON, null: false do
      description 'Retrieve a fresh board'
      argument :cols, Integer, required: true
      argument :rows, Integer, required: true
      argument :difficulty, Integer, required: true
    end

    def fetch_board(args)
      flat_board = []
      hash_board = {}
      total_rows = args[:rows] * args[:cols]
      amount_of_bombs = case args[:difficulty]
                        when 0..3
                          (total_rows * 0.25).to_i
                        when 3..7
                          (total_rows * 0.50).to_i
                        else
                          (total_rows * 0.75).to_i
                        end

      (total_rows - amount_of_bombs).times { flat_board << 0 }
      amount_of_bombs.times { flat_board << -1 }
      flat_board.shuffle.each_slice(args[:cols]).each_with_index do |filled_row, index|
        hash_board[index] = filled_row
      end
      hash_board
    end
  end
end
