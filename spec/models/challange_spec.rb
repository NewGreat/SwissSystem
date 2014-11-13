require 'rails_helper'

RSpec.describe Challange, :type => :model do
  let(:player1) {FactoryGirl.create(:player)}
  let(:player2) {FactoryGirl.create(:player)}  
  let(:round) {FactoryGirl.create(:round)}
  # context "checking bye" do
  #   xit "when there is only one player" do
  #     challange = Challange.create(player1_id: player1.id, player2_id: nil)
  #     expect(challange).to be_odd
  #   end

  #   xit "when there are two players" do
  #     challange = Challange.create(player1_id: player1.id, player2_id: player2.id)
  #     expect(challange).not_to be_odd
  #   end
  # end

  # context "checking upgrading sums of points" do
  #   xit " when there are 2 players" do
  #     challange = Challange.create(player1_id: player1.id, player2_id: player2.id)
  #     challange.update(player1_victory_points: 12, player1_battle_points: 350, player2_victory_points: 8, player2_battle_points: -350)
  #     expect(player1.victory_points_sum).to eq 12
  #     expect(player2.victory_points_sum).to eq 12
  #     expect(player1.battle_points_sum).to eq 350
  #     expect(player2.battle_points_sum).to eq -350
  #   end

  #   xit "when there is 1 player" do
  #     challange = Challange.create(player1_id: player1.id, player2_id: nil)
  #     expect(player1.victory_points_sum).to eq 13
  #     expect(player1.battle_points_sum).to eq 451
  #   end
  # end
end
