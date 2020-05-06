# frozen_string_literal: true

require_relative 'prefix'

module Ruzzle
  class Board
    module Solution
      def neighbors(row, col)
        [
          [row + 1, col],
          [row, col + 1],
          [row + 1, col + 1],
          [row - 1, col],
          [row, col - 1],
          [row - 1, col - 1]
        ]
      end

      def possible_neighbors(row, col, prefix = nil)
        all_neighbors = neighbors(row, col)

        return all_neighbors if prefix.nil?

        all_neighbors.reject { |(r, c)| prefix.include?(r, c) }
      end

      def beyond?(row, col)
        row.negative? || row > 3 || col.negative? || col > 3
      end

      def solve(vocabulary, row = 0, col = 0, prefix = nil)
        return [[]] if beyond?(row, col)

        pattern = "#{prefix}#{self[row, col]}"

        found = []
        found << pattern if vocabulary.contains?(pattern)

        [
          found,
          *possible_neighbors(row, col, prefix).map do |(r, c)|
            solve(vocabulary, r, c, Prefix.new(self, row, col, prefix))
          end
        ].inject(&:concat)
      end
    end
  end
end
