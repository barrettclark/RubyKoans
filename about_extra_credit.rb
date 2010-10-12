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
  
  def remaining_dice
    threesome = set_of_three
    remaining = @values
    3.times { remaining.delete_at(remaining.index(threesome)) } if threesome
    [2, 3, 4, 6].each { |n| remaining.delete(n) }
    remaining
  end
  
  def set_of_three
    1.upto(6) { |n| return n if @values.count(n) >= 3 }
    return nil
  end
end

class Player
end

class Game
end
