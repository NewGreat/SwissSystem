class Round < ActiveRecord::Base
  

  belongs_to :tournament
  has_many :challanges

  def start_round
    if round_number <= 1
      first_round
    else
      other_round
    end
  end

  def first_round
     tournament.players.map(&:id).shuffle!.each_slice(2) {|player1,player2| 
      Challange.create(player1_id: player1, player2_id: player2, round_id: id)
    } 
  end

  def other_round
    player_list = tournament.players.order(battle_points_sum: :desc, victory_points_sum: :desc).map(&:id)
    player1 = player_list[0] 
    player_list.delete(player1)
    player2 = player_list[0]
    while player1
      if !Player.have_played_against_each_other(player1, player2)
        Challange.create(player1_id: player1, player2_id: player2, round_id: id)
        player_list.delete(player2)
        player1 = player_list[0]
        player_list.delete(player1)
        player2 = player_list[0]
      else
        player2 = player_list[player_list.index(player2)+1]
      end
    end   
  end

  def all_challanges_finished?
    challanges.where(finished: false).count == 0
  end

  def is_finished
    self.finished = true
    save
    tournament.next_round
  end

end
