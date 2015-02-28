require 'rails_helper'

RSpec.describe Challange, :type => :model do
  let(:player1) {FactoryGirl.create(:player)}
  let(:player2) {FactoryGirl.create(:player)}  
  let(:round) {FactoryGirl.create(:round)}
  context "checking bye" do
    it "when there is only one player" do
      challange = Challange.create(player1_id: player1.id, player2_id: nil)
      expect(challange).to be_odd
    end

    it "when there are two players" do
      challange = Challange.create(player1_id: player1.id, player2_id: player2.id)
      expect(challange).not_to be_odd
    end
  end
end
