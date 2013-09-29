class Player < ActiveRecord::Base
  belongs_to :draft
  belongs_to :team

  def draft(draft_id)
    self.update_attributes(drafted: true, draft_id: draft_id)
  end

  def self.undrafted
    Player.where(drafted: false)
  end

  def self.find_by_position(position)
    Player.where(position: position).order('name DESC')
  end

end
