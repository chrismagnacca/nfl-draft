class Team < ActiveRecord::Base
  belongs_to :draft
  has_many :players

  def acquire(player)
    player.draft if not Draft.end_of_draft?
  end

end
