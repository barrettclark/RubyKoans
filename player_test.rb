require 'test_helper'
require File.expand_path(File.dirname(__FILE__) + '/about_extra_credit')

class Player
  attr_accessor :roll_scores
end

class PlayerTest < EdgeCase::TestCase
  def setup
    @risky_player = Player.new(100)
  end
  
  # def test_play_returns_a_number
  #   score = @risky_player.play
  #   assert score >= 0
  #   assert_equal score, @risky_player.score
  #   assert_equal false, @risky_player.end_game?
  # end
  
  def test_roll_with_different_dice_counts
    score = @risky_player.roll(5)
    assert score >= 0
    score = @risky_player.roll(2)
    assert score >= 0
  end
  
  def test_roll_again
    assert_equal false, @risky_player.roll_again?(200, 100)
    assert_equal false, @risky_player.roll_again?(0)
    assert_equal true, @risky_player.roll_again?(300)
    assert_equal true, @risky_player.roll_again?(1050, 25)
  end
end
