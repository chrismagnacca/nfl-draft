class PlayersController < ApplicationController

  def index
    @players = Player.all
    @draft = Draft.current
    @drafted = Draft.drafted
    @draft_over = Draft.end_of_draft?
  end

  def show
    @player = Player.where(player_params)
  end

  def undrafted
    @players = Player.where(drafted: false)
  end

  private

  def player_params
    params.require(:player).permit(:id, :name, :position)
  end
end
