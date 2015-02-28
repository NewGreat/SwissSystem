require 'rails_helper'

RSpec.describe Round, :type => :model do
  let(:tournament) {FactoryGirl.create(:tournament)}
  context "creating challanges" do
    it "when it would be first round" do
      4.times do
        FactoryGirl.create(:player, tournament_id: tournament.id)
      end
      round = Round.create(tournament_id: tournament.id, round_number: 1)
      round.start_round
      expect(round.challanges.count).to eq 2
    end

    it "when it would be another one" do
      4.times do
        FactoryGirl.create(:player, tournament_id: tournament.id)
      end
      round = Round.create(tournament_id: tournament.id, round_number: 2)
      round.start_round
      expect(round.challanges.count).to eq 2
    end

    it "when there is even number of players" do
      4.times do
        FactoryGirl.create(:player, tournament_id: tournament.id)
      end
      round = Round.create(tournament_id: tournament.id, round_number: 2)
      round.start_round
      expect(round.challanges.count).to eq 2
    end

    it "when there is odd number of players" do
      5.times do
        FactoryGirl.create(:player, tournament_id: tournament.id)
      end
      round = Round.create(tournament_id: tournament.id, round_number: 2)
      round.start_round
      expect(round.challanges.count).to eq 3
    end

    it "checking if players play against each other in subsequent games" do
        FactoryGirl.create(:player, tournament_id: tournament.id, battle_points_sum: 20)
        FactoryGirl.create(:player, tournament_id: tournament.id, battle_points_sum: 20)
      4.times do
        FactoryGirl.create(:player, tournament_id: tournament.id)
      end
      round = Round.create(tournament_id: tournament.id, round_number: 2)
      round.start_round
      round.start_round
      Player.where(tournament_id: tournament.id).each do |player1|
        Player.where(tournament_id: tournament.id).each do |player2|
          expect(player1.challanges.where("player1_id = #{player2.id} OR player2_id = #{player2.id}")
          .count).to be <= 1 unless player1 == player2
        end
      end
    end
  end
end
