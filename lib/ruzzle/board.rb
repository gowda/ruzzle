# frozen_string_literal: true

require_relative 'dictionary'
require_relative 'board/solution'

module Ruzzle
  class Board
    include Solution

    def initialize(letter_matrix)
      @matrix = letter_matrix.flatten
    end

    def [](row, col)
      @matrix[4 * row + col]
    end

    def slots
      0.upto(3).to_a.product(0.upto(3).to_a)
    end

    def words
      Enumerator.new do |yielder|
        yielded = Dictionary.new

        slots.each do |(rdx, cdx)|
          ws = solve(vocabulary, rdx, cdx)
          ws.flatten.each do |w|
            yielder.yield(w) unless yielded.contains?(w)
            yielded.add(w)
          end
        end
      end
    end

    def vocabulary
      @vocabulary ||= Dictionary.new(all_words)
    end

    def all_words
      File.readlines(words_file).map { |w| w.gsub(/\s/, '') }
    end

    def words_file
      File.expand_path('../../data/words.txt', __dir__)
    end
  end
end
