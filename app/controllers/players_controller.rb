class PlayersController < ApplicationController

  def index
    @players = Player.where(tournament_id: params[:tournament_id]).order(victory_points_sum: :desc, battle_points_sum: :desc)
  end
end
