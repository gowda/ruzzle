# frozen_string_literal: true

require 'ruzzle/board'

class BoardTest < MiniTest::Test
  def test_solutions
    letter_box = [
      %w[a s f s],
      %w[h w i t],
      %w[c t a a],
      %w[l r i n]
    ]

    words = %w[
      a
      asian
      swain
      swan
      sit
      wit
      wain
      it
      ct
      ti
      tin
      ai
      lr
    ]

    box = Ruzzle::Board.new(letter_box)
    found = box.words.to_a

    words.each do |word|
      assert_equal true, found.include?(word), "#{word} is missing"
    end

    assert_equal true, found.include?('watch'), 'watch is missing'
  end
end
