require 'rails_helper'

RSpec.describe Player, :type => :model do
  let(:player1) {FactoryGirl.create(:player)}
  let(:player2) {FactoryGirl.create(:player)}  
  let(:player3) {FactoryGirl.create(:player)}   
  let(:player4) {FactoryGirl.create(:player)}   
  let(:player5) {FactoryGirl.create(:player)}   
  let(:tournament) {FactoryGirl.create(:tournament)}
  context "checking validity of overriding associations" do
    it "when there shouldn't be any associated challanges" do
      round = FactoryGirl.create(:round, tournament_id: tournament.id)
      Challange.create(player1_id: player2.id, player2_id: player3.id, round_id: round.id)
      Challange.create(player1_id: player4.id, player2_id: player5.id, round_id: round.id)
      Challange.create(player1_id: player2.id, player2_id: player5.id, round_id: round.id)
      expect(player1.challanges.count).to eq 0
    end

    it "when there are challanges where player is stated as either player (1st or 2nd)" do
      round = FactoryGirl.create(:round, tournament_id: tournament.id)
      Challange.create(player1_id: player1.id, player2_id: player3.id, round_id: round.id)
      Challange.create(player1_id: player4.id, player2_id: player5.id, round_id: round.id)
      Challange.create(player1_id: player2.id, player2_id: player1.id, round_id: round.id)
      expect(player1.challanges.count).to eq 2
    end
  end

  context "checking validity of method for finding if players played agains each other" do
    it "when they have already played against each other and searching player was player1" do
      round = FactoryGirl.create(:round, tournament_id: tournament.id)
      Challange.create(player1_id: player1.id, player2_id: player3.id, round_id: round.id)
      Challange.create(player1_id: player4.id, player2_id: player5.id, round_id: round.id)
      Challange.create(player1_id: player2.id, player2_id: player3.id, round_id: round.id)
      expect(player1.has_played_against(player3.id)).to be
      expect(Player.have_played_against_each_other(player1.id, player3.id)).to be
    end

    it "when they have already played against each other and searching player was player2" do
      round = FactoryGirl.create(:round, tournament_id: tournament.id)
      Challange.create(player1_id: player1.id, player2_id: player3.id, round_id: round.id)
      Challange.create(player1_id: player4.id, player2_id: player5.id, round_id: round.id)
      Challange.create(player1_id: player2.id, player2_id: player3.id, round_id: round.id)
      expect(player3.has_played_against(player1.id)).to be
      expect(Player.have_played_against_each_other(player3.id, player1.id)).to be
    end

    it "when they haven't played agains each other yet" do
      round = FactoryGirl.create(:round, tournament_id: tournament.id)
      Challange.create(player1_id: player1.id, player2_id: player3.id, round_id: round.id)
      Challange.create(player1_id: player4.id, player2_id: player5.id, round_id: round.id)
      Challange.create(player1_id: player2.id, player2_id: player3.id, round_id: round.id)

      expect(player1.has_played_against(player4.id)).not_to be
      expect(Player.have_played_against_each_other(player1.id, player4.id)).not_to be

      expect(player4.has_played_against(player1.id)).not_to be
      expect(Player.have_played_against_each_other(player4.id, player1.id)).not_to be
    end
  end

end
