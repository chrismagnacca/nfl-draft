class DraftsController < ApplicationController

  def index
    @draft = Draft.current
    @drafted = Draft.drafted
    @draft_over = Draft.end_of_draft?
  end

  def drafts
    @drafts = Draft.all
  end

  def results
    @results = Draft.results
  end

  private

  def draft_params
    params.require(:draft).permit(:team_id, :player_id, :round, :pick, :executed)
  end
end
