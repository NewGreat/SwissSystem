class Player < ActiveRecord::Base

  # after_create :set_sums
  
  validates :name, :surname, presence: true

  belongs_to :tournament
  
  # has_many challanges has been overriden by method of the name challanges. 
  # Rails lack methods to parralelly bond tables with 2 different keys at once.
  def challanges
    Tournament.find(tournament_id).challanges.where("player2_id = #{id} OR player1_id = #{id}")
  end

  def self.have_played_against_each_other(player1, player2)
    find(player1).challanges.each do |challange|
      return true if challange.player2_id == player2 || challange.player1_id == player2  
    end
    false
  end
  
  def has_played_against(opponent)
    challanges.each do |challange|
      return true if challange.player2_id == opponent || challange.player1_id == opponent  
    end
    false
  end

  def full_name
    "#{name} #{surname}"
  end

  private

  def set_sums
    self.battle_points_sum = 0
    self.victory_points_sum = 0
    challanges_count = 0
    save
  end
end
