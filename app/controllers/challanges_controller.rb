class ChallangesController < ApplicationController

  def update
    @challange = Challange.find(params[:id])
    unless @challange.finished?
      @challange.set_as_finished
      respond_to do |format|
        if @challange.update(challange_params)
          format.html {redirecting_to_right_path_after_updating}
        else
          format.html {redirect_to tournament_path(@challange.tournament), notice: 'Challange wasn\'t updated.'}
        end
      end
    else
      redirect_to tournament_path(@challange.tournament), notice: 'These results were already typed in'
    end
  end

  private
  
  def challange_params
    params.require(:challange).permit(:player1_victory_points, :player2_victory_points, :player1_battle_points, :player2_battle_points)
  end 

  def redirecting_to_right_path_after_updateing
    unless @challange.tournament.finished?
      redirect_to tournament_path(@challange.tournament), notice: 'Challange was successfully updated.'
    else
      redirect_to players_path(tournament_id: @challange.tournament.id), notice: 'Challange was successfully updated. And tournament finished'
    end
  end

end
