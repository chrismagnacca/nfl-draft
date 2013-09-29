class Team < ActiveRecord::Base
  belongs_to :draft
  has_many :players

  def acquire(player)
    player.draft(Draft.current.id) if not Draft.end_of_draft?
    Draft.current.update_attributes(player_id: player.id, executed: true)
  end

end
