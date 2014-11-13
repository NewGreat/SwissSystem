class Tournament < ActiveRecord::Base

  # after_create :not_finished
  before_save :set_time
  attr_accessor :hours, :minutes

  has_many :rounds
  has_many :players
  has_many :challanges, through: :rounds



  def self.current
    where(finished: false).last
  end

  def next_round
    if !(rounds.count == max_round_number)
      round = Round.create(round_number: (rounds.count+1), tournament_id: id)
      round.start_round
    else
      finish
    end
  end

  def show_if_finished
    "finished" if finished
    "ongoing" unless finished
  end

  def current_round_number
    if current_round
      current_round.round_number 
    elsif finished
      "finished"
    else
      "not started yet"
    end  
  end

  def current_round
    rounds.where(finished: false).first
  end

  def results
    players.order('battle_points_sum victory_points_sum')
  end

  private

  def start
    round = Round.new(round_number:1).save
    round.first_round
  end

  def finish
    self.finished = true
    save
    # redirect_to players_path(tournament_id: id)
  end

  def not_finished
    self.finished = false
    save
  end

  def set_time
    self.time = @hours.to_i*60 + @minutes.to_i
  end

end
