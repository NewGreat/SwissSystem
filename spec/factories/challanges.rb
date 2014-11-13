FactoryGirl.define do
  factory :challange do
    round_id 1
    player1_id 1
    player2_id 2
    table_number 1
    player1_victory_points 0
    player2_victory_points 0
    player1_battle_points 0
    player2_battle_points 0
    finished false
  end

end
