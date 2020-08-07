require 'rails_helper'

RSpec.describe Board, type: :transaction do
  subject { described_class.call(params: params) }

  context 'generating a 10x10 new board' do
    let(:params) do
      {
        cols: 10,
        rows: 10
      }
    end

    it { is_expected.to be_success }

    it 'retrieves the board as a Hash' do
      expect(subject.success).to be_a(Hash)
    end

    it 'has correct dimensions' do
      hash_board = subject.success
      flattened_board = hash_board.values.flatten
      expect(hash_board.keys.length).to eq 10
      expect(flattened_board.length).to eq 100
    end

    it 'defaults difficulty to 5 (amount of bombs = 1/2 times total amount oftal cells)' do
      hash_board = subject.success
      flattened_board = hash_board.values.flatten
      expect(flattened_board.count(-1)).to eq (flattened_board.length * 0.5)
    end

    context 'custom difficulties' do
      let(:params) do
        {
          cols: 10,
          rows: 10,
          difficulty: 1
        }
      end

      it 'difficulty easy bombs = 1/4 times total amount of cells' do
        hash_board = subject.success
        flattened_board = hash_board.values.flatten
        expect(flattened_board.count(-1)).to eq (flattened_board.length * 0.25)
      end
    end
  end
end
