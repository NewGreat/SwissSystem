require 'json'

class Tournament < ActiveRecord::Base

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

  def set_time(hours, minutes)
    self.time = hours.to_i*60 + minutes.to_i
  end

  private

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
    file = File.open("results/#{name}.json","w") do |f|
      f.write(json_file.to_json)
    end
    file.close
    ResultsMailer.sending_results(name).deliver
  end

  def generate_results_json
    results.map.with_index do |result,position|
      {name: result.name, surname:result.surname, position:position+1}
    end
  end

end
