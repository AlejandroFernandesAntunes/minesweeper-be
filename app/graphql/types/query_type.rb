module Types
  class QueryType < Types::BaseObject
    field :fetch_board, GraphQL::Types::JSON, null: false do
      description 'Retrieve a fresh board'
      argument :cols, Integer, required: true
      argument :rows, Integer, required: true
      argument :difficulty, Integer, required: true
    end

    def fetch_board(args)
      board = Board.({ params: args })
      board.success || {}
    end
  end
end
