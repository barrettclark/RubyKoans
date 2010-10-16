require 'test_helper'
require File.expand_path(File.dirname(__FILE__) + '/about_extra_credit')

class GameTest < EdgeCase::TestCase
  def setup
    @game = Game.new
  end
  
  def test_game_initializes_with_players
    assert_equal 2, @game.players.count
  end
  
  def test_play_initial_round
    leader = @game.play_initial_round
    assert leader.is_a?(Player)
    assert leader.end_game?
  end
  
  def test_play_lightening_round
    leader = @game.players[0]
    @game.play_lightening_round(leader)
    assert leader.score <= @game.players.last.score
  end
end
