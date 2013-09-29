class DraftsController < ApplicationController

  def index
    @draft = Draft.current
    @drafted = Draft.drafted
    @draft_over = Draft.end_of_draft?
    @next = Draft.next
  end

  def show
    @draft = Draft.where(id: params[:id]).first
    @positions = Player.select(:position).uniq
    @undrafted_players = Player.undrafted
  end

  def drafts
    @drafts = Draft.all
  end

  def results
    @results = Draft.results
  end

  def draft
    player = Player.where(id: params[:id])

    if player.drafted
      flash[:alert] = 'whoops! looks like that player has been drafted'
      redirect_to draft_path(Draft.current)
    end

    Draft.current.team.acquire(player)
    Draft.current.update_attributes(player_id: player.id)
    flash[:notice] = 'player was successfully drafted!'

    redirect_to root_path if Draft.end_of_draft
    redirect_to draft_path(Draft.current)
  end

  private

  def draft_params
    params.require(:draft).permit(:id, :team_id, :player_id, :round, :pick, :executed) if params[:draft]
  end
end
