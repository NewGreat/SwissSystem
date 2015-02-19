require 'rails_helper'

RSpec.describe Tournament, :type => :model do
  let(:tournament) {FactoryGirl.create(:tournament)}

  context "checking for valid starting of the rounds" do
    it "when it would be first round" do
      expect(tournament.rounds.count).to eq 0
      tournament.next_round
      expect(tournament.rounds.count).to eq 1
    end
    it "when it would be some round in the middle" do
      FactoryGirl.create(:round, tournament_id: tournament.id, finished: true)
      expect(tournament.rounds.count).to eq 1
      tournament.next_round
      expect(tournament.rounds.count).to eq 2  
    end   

    it "when it would be last round" do
      (tournament.max_round_number.to_i).times do
        FactoryGirl.create(:round, tournament_id: tournament.id, finished: true)
      end
      expect(tournament.rounds.count).to eq tournament.max_round_number.to_i
      tournament.next_round
      expect(tournament.rounds.count).to eq tournament.max_round_number.to_i
      expect(tournament.finished).to be
    end
  end
end
