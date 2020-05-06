# frozen_string_literal: true

require 'ruzzle/dictionary'

module DictionaryTest
  class EmptyDictionaryTest < MiniTest::Test
    attr_reader :dictionary

    def setup
      @dictionary = Ruzzle::Dictionary.new
    end

    def test_contains?
      assert_equal false, dictionary.contains?(''),
                   'empty string should never be in any dictionary'
      assert_equal false, dictionary.contains?('a'),
                   '"a" should not be in an empty dictionary'
      assert_equal false, dictionary.contains?('cat'),
                   '"cat" should not be in an empty dictionary'
    end

    def test_prefix?
      assert_equal false, dictionary.prefix?('')
      assert_equal false, dictionary.prefix?('a')
      assert_equal false, dictionary.prefix?('ca')
    end

    def test_add
      word = 'ruzzle'
      dictionary.add(word)

      assert_equal true, dictionary.contains?(word),
                   "#{word} should be in dictionary"
      assert_equal false, dictionary.prefix?(word),
                   "#{word} should not be a prefix in dictionary"

      (word.length - 2).downto(1) do |index|
        assert_equal true, dictionary.prefix?(word[0..index]),
                     "#{word[0..index]} should be a prefix in dictionary"
      end
    end

    def test_add_blank_string
      blank_string = <<~BLANK_STRING


      BLANK_STRING

      dictionary.add(blank_string)

      assert_equal false, dictionary.contains?(blank_string)
    end
  end

  class SingleWordDictionaryTest < MiniTest::Test
    attr_reader :dictionary
    attr_reader :word

    def setup
      @word = 'hello'
      @dictionary = Ruzzle::Dictionary.new([@word])
    end

    def test_contains?
      assert_equal true, dictionary.contains?(word),
                   "#{word} should be in dictionary"
    end

    def test_prefix?
      assert_equal false, dictionary.prefix?(''),
                   'empty string should never be a prefix in any dictionary'
      assert_equal false, dictionary.prefix?(word),
                   "#{word} should not be a prefix in dictionary"

      (word.length - 2).downto(1).each do |index|
        assert_equal true, dictionary.prefix?(word[0..index]),
                     "#{word[0..index]} should be a prefix in dictionary"
      end
    end

    def test_add
      new_word = 'ruzzle'
      dictionary.add(new_word)

      assert_equal true, dictionary.contains?(word),
                   "#{word} should be in dictionary"
      assert_equal true, dictionary.contains?(new_word),
                   "#{new_word} should be in dictionary"

      (new_word.length - 2).downto(1).each do |index|
        assert_equal true, dictionary.prefix?(new_word[0..index]),
                     "#{new_word[0..index]} should be a prefix in dictionary"
      end
    end

    def test_add_blank_string
      blank_string = <<~BLANK_STRING


      BLANK_STRING

      dictionary.add(blank_string)

      assert_equal false, dictionary.contains?(blank_string)
    end
  end

  class LargeDictionaryTest < MiniTest::Test
    attr_reader :dictionary
    attr_reader :words, :other_words

    def words_file
      File.expand_path('../../data/words.txt', __dir__)
    end

    def all_words
      File.readlines(words_file)
          .map { |word| word.gsub(/\s/, '') }
    end

    def setup
      @words = all_words.sample(10)
      @other_words = (all_words - @words).sample(10)

      @dictionary = Ruzzle::Dictionary.new(@words)
    end

    def test_contains?
      words.sample(10).each do |word|
        assert_equal true, dictionary.contains?(word),
                     "#{word} should be in dictionary"
      end

      other_words.sample(10).each do |word|
        assert_equal false, dictionary.contains?(word),
                     "#{word} should not be in dictionary"
      end
    end

    def test_prefix?
      words.sample(10).each do |word|
        (word.length - 2).downto(1) do |index|
          assert_equal true, dictionary.prefix?(word[0..index]),
                       "#{word[0..index]} should be a prefix in dictionary"
        end
      end

      non_existent_word = ('a'..'z').to_a.shuffle.join

      assert_equal false, dictionary.prefix?(non_existent_word),
                   "#{non_existent_word} should not a prefix in dictionary"
    end

    def test_add
      word = 'ruzzle'

      dictionary.add(word)

      assert_equal true, dictionary.contains?(word),
                   "#{word} should be in dictionary"
      assert_equal false, dictionary.prefix?(word),
                   "#{word} should not be a prefix in dictionary"

      (word.length - 2).downto(1) do |index|
        assert_equal true, dictionary.prefix?(word[0..index]),
                     "#{word[0..index]} should be a prefix in dictionary"
      end
    end
  end
end
