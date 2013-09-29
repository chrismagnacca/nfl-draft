require 'spec_helper'

describe Draft do
  Given!(:draft) { Draft.create(round: 1, pick: 1, team_id: 1) }
  Given!(:next_draft) { Draft.create(round: 1, pick: 2, team_id: 2) }
  Given!(:team) { Team.create(name: 'San Francisco 49ers', division: 'NFC West') }
  Given!(:colin) { Player.create(name: 'Colin Kaepernick', position: 'QB', drafted: false) }
  Given!(:willis) { Player.create(name: 'Willis McGahee', position: 'RB', drafted: false) }

  Then { draft.should respond_to(:round) }
  Then { draft.should respond_to(:pick) }
  Then { draft.should respond_to(:team_id) }
  Then { draft.should respond_to(:team) }
  Then { draft.should respond_to(:player) }
  Then { draft.should respond_to(:player_id) }

  context 'drafted results should be empty with no drafts' do
    Then { Draft.results.should be_empty }
  end

  context 'drafted results should not be empty after a draft' do
    When { team.acquire(colin) }
    Then { Draft.results.should_not be_empty }
    Then { Draft.drafted.should_not be_empty }
    Then { Draft.drafted.first.player_id.should eq(colin.id) }
  end

  context 'current returns first unexecuted step' do
    Then { Draft.current.should eq(draft) }

    context 'context returns unexecuted step after first as well' do
      When { team.acquire(colin) }
      Then { Draft.current.should eq(next_draft) }

    end
  end

  context 'drafted next should show next pick' do
    Then { Draft.next.should_not be_nil }
    Then { Draft.next.should eq(next_draft) }

    context 'previous shows last drafted' do
      Then { Draft.previous.should_not be_nil }
      Then { Draft.previous.should eq(draft) }
    end
  end

  context 'end of draft returns is false at the start' do
    Then { Draft.end_of_draft?.should be_false }

    context 'end of draft returns false mid draft' do
      When { team.acquire(colin) }
      Then { Draft.end_of_draft?.should be_false }
    end

    context 'end of draft returns true at 255th record' do
      When { Draft.current.update_attributes(pick: 255) }
      Then { Draft.end_of_draft?.should be_true }
    end

  end

end
