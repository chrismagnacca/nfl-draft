class PlayersController < ApplicationController

  def index
    @players = Player.all.order('drafted DESC')
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

  def filter
    @undrafted_players = nil
    if not params['position'] == 'all'
      @undrafted_players = Player.find_by_position(params['position'])
    else
      @undrafted_players = Player.undrafted
    end

    partial = render_to_string(template: 'shared/_undrafted_players', undrafted_players: @undrafted_players)
    respond_to do |format|
      format.json { render json: { success:true, html: partial } }
      format.html { }
    end
  end

  private

  def player_params
    params.require(:player).permit(:id, :name, :position, 'position')
  end
end
