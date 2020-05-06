# frozen_string_literal: true

module Ruzzle
  class Board
    class Prefix
      attr_reader :row, :col

      def initialize(box, row, col, previous = nil)
        @box = box

        @previous = previous
        @row = row
        @col = col
      end

      def char
        @box[@row, @col]
      end

      def to_s
        return "#{@previous}#{char}" if @previous

        char
      end

      def include?(r, c)
        (@row == r && @col == c) ||
          (@previous ? @previous.include?(r, c) : false)
      end

      def to_a
        [[char, [@row, @col]]] if @previous.nil?

        [[char, [@row, @col]]].concat(@previous.to_a)
      end
    end
  end
end
