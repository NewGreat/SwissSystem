class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.find(params[:id])
    @player = Player.new(tournament_id: @tournament.id)
    session[:tournament_id] = @tournament.id
    redirect_to players_path(tournament_id: params[:id]) if @tournament.finished
    @rounds = @tournament.rounds
  end

  def finish
    tournament = Tournament.find(params[:id])
    unless tournament.current_round || tournament.finished?
      tournament.next_round
    end
    redirect_to tournament_path(id: params[:id])
  end

  def start
    tournament = Tournament.find(params[:id])
    unless tournament.current_round || tournament.finished?
      tournament.next_round
    end
    redirect_to tournament_path(id: params[:id])
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
    @tournament = Tournament.new(tournament_params)
    @tournament.set_time(tournament_params[:hours],tournament_params[:minutes])
    if @tournament.save
      redirect_to tournaments_path
    else
      render :new
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:name, :max_round_number, :hours, :minutes)
  end
end
