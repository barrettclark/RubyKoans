# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.
require 'logger'

class DiceSet
  attr_reader :values
  def roll(n)
    @values = (1..n).map { rand(6) + 1 }
  end

  def score(vals = @values)
    score = 0
    rolls = Hash.new(0)
    vals.each { |roll| rolls[roll] += 1 }
    rolls.each do |roll, count|
      if count >= 3
        score += roll == 1 ? 1000 : (roll * 100)
        count -= 3
      end
      score += count * 100 if (count > 0 && roll == 1)
      score += count * 50 if (count > 0 && roll == 5)
    end
    score
  end
  
  def remaining_dice_count
    threesome = set_of_three
    remaining = @values
    3.times { remaining.delete_at(remaining.index(threesome)) } if threesome
    [1, 5].each { |n| remaining.delete(n) }
    remaining.count
  end
  
  def set_of_three
    1.upto(6) { |n| return n if @values.count(n) >= 3 }
    return nil
  end
end

class Player
  attr_reader :score
  def initialize(risk_factor = rand(100))
    @log = Logger.new(STDOUT)
    @log.level = Logger::INFO
    @dice = DiceSet.new
    @score = 0
    @risk_factor = risk_factor
    @log.debug "Player created with a risk factor of #{@risk_factor}"
  end
  
  def calculate_turn_score(roll_scores)
    score = 0
    if roll_scores.last != 0
      score += roll_scores.inject { |sum, score| sum += score }
    end
    score
  end
  
  def end_game?
    @score >= 3000
  end

  def play
    dice_count = 5
    roll_scores = []
    while end_game? == false
      roll_scores << roll(dice_count)
      if roll_again?(roll_scores.last)
        remaining_dice_count = @dice.remaining_dice_count
        dice_count = remaining_dice_count > 0 ? remaining_dice_count : 5
      else
        @log.debug "Player is finished with this turn"
        break
      end
    end
    @score += calculate_turn_score(roll_scores) unless roll_scores.empty?
    @score
  end
  
  def final_roll
    @score += calculate_turn_score(roll(5))
  end
  
  def roll(dice_count)
    @dice.roll(dice_count)
    @log.debug "Player rolled: #{@dice.values} for a score of #{@dice.score}"
    @dice.score
  end

  def roll_again?(score, roll_chance = rand(100))
    score >= 300 && roll_chance <= @risk_factor
  end
end

class Game
  attr_reader :players
  def initialize(player_count = 2)
    @players = []
    player_count.times { @players << Player.new }
  end
  
  def play
    leader = play_initial_round
  end
  
  def play_initial_round
    while true
      @players.each do |player|
        player.play
        return player if player.end_game?
      end
    end
  end
  
  def play_lightening_round(leader)
    remaining_players = @players - [leader]
    remaining_players.each { |player| player.final_roll }
  end
  
  def announce_winner
    
  end
end
