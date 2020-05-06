# frozen_string_literal: true

require 'ruzzle/binary_search'

class BinarySearchTest < MiniTest::Test
  using Ruzzle::BinarySearch

  def test_empty_array
    array = []
    end_index = -1

    assert_equal end_index, array.index(1), '1 should be added at 0'
    assert_equal end_index, array.index(-1), '-1 should be added at 0'
    assert_equal end_index, array.index(2), '2 should be added at 0'
  end

  def test_single_element_array
    array = [1]

    assert_equal 0, array.index(1), '1 should be at 0'

    [[0, -2], [2, -1]].each do |element, expected_index|
      assert_equal expected_index, array.index(element),
                   "#{element} should be added at #{expected_index} position"
    end
  end

  def test_small_array
    array = [9, 4, 6, 3, 8, 1, 5, 7, 2]
    array.sort!

    assert_equal 0, array.index(1), '1 should be at index 0'
    assert_equal 8, array.index(9), '9 should be at index 8'

    [[10, -1], [-1, -10], [6.5, -4]].each do |element, expected_index|
      assert_equal expected_index, array.index(element),
                   "#{element} should be added at #{expected_index} position"
    end
  end
end
