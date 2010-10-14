require 'test_helper'
require File.expand_path(File.dirname(__FILE__) + '/about_extra_credit')

class PlayerTest < EdgeCase::TestCase
  def setup
    @player = Player.new
  end
  
  def test_play_returns_a_number
    score = @player.play
    assert score >= 0
    assert_equal score, @player.score
  end
end
