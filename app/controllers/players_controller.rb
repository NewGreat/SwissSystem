class PlayersController < ApplicationController

  def index
    @players = Player.where(tournament_id: params[:tournament_id]).order(victory_points_sum: :desc, battle_points_sum: :desc)
  end

  def new
    tournament = Tournament.find(params[:tournament_id])
    unless (tournament.current_round || tournament.finished)
      @player = Player.new(tournament_id: params[:tournament_id])
    else
      flash[:notice] = "You cannot add players once tournament has started"
      redirect_to root_path
    end
  end


  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to tournament_path(@player.tournament_id)
    else
      render :new
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :surname, :tournament_id)
  end
end