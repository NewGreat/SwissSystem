class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.find(params[:id])
    session[:tournament_id] = @tournament.id
    redirect_to players_path(tournament_id: params[:id]) if @tournament.finished
    @active_round = @tournament.current_round
    @rounds = @tournament.rounds
  end

  def start

    tournament = Tournament.find(params[:id])
    redirect_to tournament_path(id: params[:id])
    unless tournament.current_round || tournament.finished
      tournament.next_round
    end
  end

  def edit
       @tournament = Tournament.find(params[:id])
    if Tournament.find(params[:id]).current_round || Tournament.find(params[:id]).finished
      flash[:notice] = "You cannot change tournament rules after it has started"
      redirect_to root_path
    end
 
  end

  def update
    if @post.update_attributes(tournament_params)
      flash[:notice] = "Tournament rules updated"
      redirect_to @tournament
    else
      render :edit
    end
  end

  def new
    @tournament = Tournament.new
  end
  
  def create
    # time = params[:hours]*60 + params[:min]
  end

  private

  def tournament_params
    params.require(:tournament).permit(:time, :name, :max_round_number)
  end
end
