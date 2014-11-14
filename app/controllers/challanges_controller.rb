class ChallangesController < ApplicationController

  def update
    @challange = Challange.find(params[:id])
    unless @challange.finished?
      @challange.set_as_finished
      respond_to do |format|
        if @challange.update(challange_params)
          # if request.xhr?
          #   unless @challange.tournament.finished?
          #     unless @challange.round.finished?
          #       render partial: 'form', locals: { challange: @challange}
          #     else 
          #       render tournament_path(@challange.tournament)
          #     end
          #   else
          #     render players_path(tournament_id: @challange.tournament.id), notice: 'Challange was successfully updated. And tournament finished.'
          #   end
          # end
          #end
          format.html do
            unless @challange.tournament.finished?
              redirect_to tournament_path(@challange.tournament), notice: 'Challange was successfully updated.'
            else
              redirect_to players_path(tournament_id: @challange.tournament.id), notice: 'Challange was successfully updated. And tournament finished'
            end
          end
        else
          format.html do
            redirect_to tournament_path(@challange.tournament), notice: 'Challange wasn\'t updated.'
          end
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
end
