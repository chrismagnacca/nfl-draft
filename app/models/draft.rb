class Draft < ActiveRecord::Base
  has_one :team
  has_one :player

  def team
    Team.where(id: self.team_id).first
  end

  def self.current
    Draft.where(executed: false).first
  end

  def self.next
    Draft.where(pick: Draft.current.pick + 1).first
  end

  def self.previous
    draft = Draft.current
    return Draft.where(pick: Draft.current.pick - 1) if (draft.pick != 1)
    return draft
  end

  def self.drafted
    Draft.where(executed: true)[0...3]
  end

  def self.results
    Draft.where(executed: true)
  end

  def self.end_of_draft?
    (Draft.current.pick == 255)
  end

end
