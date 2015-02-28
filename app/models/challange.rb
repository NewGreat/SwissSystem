class Challange < ActiveRecord::Base

  validate :cannot_have_incorrect_points, unless: :odd?, on: :update
  
  after_create :mark_bye, if: :odd?
  after_update :update_player_sum 
  after_update :mark_round_as_finished, if: :all_challanges_finished?

  belongs_to :round
                         # belongs_to :tournament,  through: :round is not a method in rails. 
                         # I have overriden it by method current_tournament
  
  belongs_to :player1, class_name: 'Player' 
  belongs_to :player2, class_name: 'Player'

  delegate :all_challanges_finished?, :tournament, to: :round, allow_nil: true

  def odd?
    !player2_id
  end

  def tournament
    round.tournament
  end

  def current_tournament
    round.tournament
  end

  def set_as_finished 
    self.finished = true
  end
  private 

  def correct_input_of_points?
    correct_victory_points? && correct_battle_points?
  end

  def cannot_have_incorrect_points
    unless correct_input_of_points?
      errors.add :base, "inputs are incorrect" 
    end
  end 

  def correct_victory_points?
    player1_victory_points + player2_victory_points == 20 
  end

  def correct_battle_points?
    player1_battle_points + player2_battle_points == 0
  end

  def mark_round_as_finished
    round.is_finished
  end

  
    
  def mark_bye
    self.player1_victory_points = 13
    self.player1_battle_points = 451
    self.finished = true
    save

  end

  def update_player_sum
    player1.victory_points_sum += player1_victory_points
    player1.battle_points_sum  += player1_battle_points
    player1.challanges_count+=1
    player1.save
    if player2
      player2.victory_points_sum += player2_victory_points
      player2.battle_points_sum  += player2_battle_points
      player2.challanges_count+=1
      player2.save
    end
  end
end
