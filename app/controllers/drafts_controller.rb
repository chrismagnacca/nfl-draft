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

  def acquire
    player = Player.where(id: params[:id]).first
    if player.drafted
      flash[:alert] = 'whoops! looks like that player has been drafted'
      redirect_to draft_path(Draft.current)
      return
    end

    Draft.current.team.acquire(player)
    flash[:notice] = 'player was successfully drafted!'

    if Draft.end_of_draft?
      redirect_to root_path
      return
    else
      redirect_to draft_path(Draft.current)
      return
    end

  end

  private

  def draft_params
    params.require(:draft).permit(:id, :team_id, :player_id, :round, :pick, :executed, :player) if params[:draft]
  end
end
