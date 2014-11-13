class ChallangesController < ApplicationController
  # respond_to :html
  # def new
  # end

  # def create
  # end

  def update
    @challange = Challange.find(params[:id])
    @challange.set_as_finished
    # respond_to do |format|
    #   if @challange.update(challange_params)
    #     # if request.xhr?
    #     #   render partial: 'form', locals: { challange: Challange.find(params[:id])}
    #     # else
    #     format.html {
    #       if (@challange.tournament.finished?)
    #         redirect_to players_path(tournament_id: @challange.tournament.id), notice: 'Challange was successfully updated. And tournament finished'
    #       else
    #         redirect_to tournament_path(@challange.tournament), notice: 'Challange was successfully updated.'
    #       end
    #     }
    #     # end
    #   end
    # end
    respond_to do |format|
      if @challange.update(challange_params)
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
  end

  private
  
  def challange_params
    params.require(:challange).permit(:player1_victory_points, :player2_victory_points, :player1_battle_points, :player2_battle_points)
  end 
end
