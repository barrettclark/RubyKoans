require 'test_helper'
require File.expand_path(File.dirname(__FILE__) + '/about_extra_credit')

class Player
  attr_accessor :score
end

class PlayerTest < EdgeCase::TestCase
  def setup
    @risky_player = Player.new('Risky Player', 100)
  end
  
  def test_play_returns_a_number
    score = @risky_player.play
    assert score >= 0
    assert_equal score, @risky_player.score
    assert_equal false, @risky_player.end_game?
  end
  
  def test_calculate_turn_score
    assert_equal 350, @risky_player.calculate_turn_score([300, 50])
    assert_equal 0, @risky_player.calculate_turn_score([300, 50, 0])
  end
  
  def test_roll_with_different_dice_counts
    score = @risky_player.roll(5)
    assert score >= 0
    assert_equal false, @risky_player.end_game?
    score = @risky_player.roll(2)
    assert score >= 0
  end
  
  def test_roll_again
    assert_equal false, @risky_player.roll_again?(200, 100)
    assert_equal false, @risky_player.roll_again?(0)
    assert_equal true, @risky_player.roll_again?(300)
    assert_equal true, @risky_player.roll_again?(1050, 25)
  end
  
  def test_that_a_player_can_get_3000_points
    loop_count = 0
    while @risky_player.score < 3000
      loop_count += 1
      @risky_player.play
    end
    assert loop_count > 1
    assert @risky_player.score >= 3000
  end
  
  def test_sort
    @player2 = Player.new('Player 2')
    @player3 = Player.new('Player 3')
    @risky_player.score = 100
    @player2.score = 1000
    @player3.score = 0
    players = [@risky_player, @player2, @player3]
    players.sort!
    assert_equal @player2, players.last
  end
end
