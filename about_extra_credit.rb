# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.

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
    [2, 3, 4, 6].each { |n| remaining.delete(n) }
    remaining.count
  end
  
  def set_of_three
    1.upto(6) { |n| return n if @values.count(n) >= 3 }
    return nil
  end
end

class Player
  attr_reader :score
  def initialize
    @dice = DiceSet.new
    @dice_count = 5
    @score = 0
    @risk_factor = rand(100)
    puts "Player created with a risk factor of #{@risk_factor}"
  end
  
  def play
    turn_score = 0
    while end_game? == false
      roll
      break if @dice.score == 0
      turn_score += @dice.score
      break unless roll_again?
      @dice_count = @dice.remaining_dice_count > 0 ? @dice.remaining_dice_count : 5
    end
    @score += turn_score
  end
  
  private
  def end_game?
    @score >= 3000
  end
  def roll
    @dice.roll(@dice_count)
    puts "Player rolled: #{@dice.values} for a score of #{@dice.score}"
  end
  def roll_again?
    @dice.score > 0 && rand(100) >= @risk_factor
  end
end

class Game
end
