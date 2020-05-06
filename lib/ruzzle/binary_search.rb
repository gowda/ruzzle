# frozen_string_literal: true

module Ruzzle
  module BinarySearch
    class NotSortedError < StandardError
    end

    refine Array do
      def index(element)
        binary_search(element, 0, length - 1)
      end

      def binary_search(element, left, right)
        return - (length - right) if left > right

        middle = (left + right) / 2

        return middle if self[middle] == element

        if element < self[middle]
          right = middle - 1
        elsif element > self[middle]
          left = middle + 1
        end

        binary_search(element, left, right)
      end
    end
  end
end
