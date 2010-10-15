require 'test_helper'
require File.expand_path(File.dirname(__FILE__) + '/about_extra_credit')

class DiceSet
  # reopen DiceSet to add a setter for the roll value(s)
  def set_values(values)
    @values = values
  end
end

class DiceSetTest < EdgeCase::TestCase
  def setup
    @dice = DiceSet.new
  end
  
  def test_create_new_dice_set
    assert_not_nil @dice
  end
  
  def test_roll_the_dice
    @dice.roll(5)
    assert_equal 5, @dice.values.count
    @dice.values.each do |die|
      assert die >= 1
      assert die <= 6
    end
  end
  
  def test_dice_have_a_score
    @dice.roll(5)
    assert @dice.score >= 0
  end
  
  def test_set_of_three
    @dice.set_values([1, 1, 1, 1, 1])
    assert_equal 1, @dice.set_of_three

    @dice.set_values([1, 2, 3, 4, 5])
    assert_nil @dice.set_of_three
  end
  
  def test_remaining_dice_count
    @dice.set_values([1, 1, 1, 1, 1])
    assert_equal 0, @dice.remaining_dice_count

    @dice.set_values([1, 2, 3, 4, 5])
    assert_equal 3, @dice.remaining_dice_count

    @dice.set_values([1, 1, 1, 4, 5])
    assert_equal 1, @dice.remaining_dice_count

    @dice.set_values([3, 3, 3, 6, 6])
    assert_equal 2, @dice.remaining_dice_count

    @dice.set_values([2, 2, 4, 4, 6])
    assert_equal 5, @dice.remaining_dice_count
  end
end
