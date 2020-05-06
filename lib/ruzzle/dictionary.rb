# frozen_string_literal: true

require_relative 'binary_search'

module Ruzzle
  class Dictionary
    attr_reader :words

    using BinarySearch

    def initialize(words = [])
      @words = words.dup
      @words.sort!
    end

    def add(word)
      return if word.strip.empty?

      index = words.index(word)
      return false if index.positive?

      words.insert(index, word)
      true
    end

    def prefix?(str)
      return false if words.empty?
      return false if str.strip.empty?

      index = words.index(str)

      words[index + 1]&.start_with?(str) || false
    end

    def contains?(str)
      return false if words.empty?
      return false if str.strip.empty?

      !words.index(str).negative?
    end

    def to_s
      words.join(',')
    end
  end
end
