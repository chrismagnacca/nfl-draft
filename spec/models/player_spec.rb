require 'spec_helper'

describe Player do
  Given!(:colin) { Player.create(name: 'Colin Kaepernick', position: 'QB', drafted: false) }
  Given!(:willis) { Player.create(name: 'Willis McGahee', position: 'RB', drafted: false) }

  Then { colin.should respond_to(:name) }
  Then { colin.should respond_to(:position) }
  Then { colin.should respond_to(:drafted) }
  Then { colin.should respond_to(:team) }
  Then { colin.should respond_to(:draft) }

  context 'drafted should be false for undrafted players' do
    Then { colin.drafted.should be_false }
  end

  context 'drafted should be true after a player has been drafted' do
    When { colin.draft }
    Then { colin.drafted.should be_true }
  end

  context 'find by position filters players' do
    Then { Player.find_by_position('QB').first.should eq(colin) }
    Then { Player.find_by_position('RB').first.should eq(willis) }
  end

  context 'undrafted returns players yet to be acquired' do
    When { colin.draft }
    When(:undrafted) { Player.undrafted }
    Then { undrafted.count.should eq(1) }
    Then { undrafted.first.should eq(willis) }
  end

end
