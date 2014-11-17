require 'json'

class Tournament < ActiveRecord::Base

  attr_accessor :hours, :minutes

  before_save :set_time
  validates :name, presence: true
  validates :max_round_number, numericality: { greater_than: 0}
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
    if finished?
      "finished" 
    else
      "ongoing" 
    end
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
    players.order(battle_points_sum: :desc, victory_points_sum: :desc)
  end

  private

  def set_time
    self.time = @hours*60 + @minutes
  end

  def start
    round = Round.new(round_number:1).save
    round.first_round
  end

  def finish
    self.finished = true
    save
    send_json(generate_results_json)
  end

  def send_json(json_file)
    File.open("results/#{name}.json","w") do |f|
      f.write(json_file.to_json)
    end
    ResultsMailer.sending_results(name).deliver
    File.delete("results/#{name}.json")
  end

  def generate_results_json
    results.map.with_index do |result,position|
      {name: result.name, surname:result.surname, position:position+1}
    end
  end

end
