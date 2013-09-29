require 'spec_helper'

describe Team do
  Given!(:team) { Team.create(name: 'San Francisco 49ers', division: 'NFC West') }

  Then { team.should respond_to(:name) }
  Then { team.should respond_to(:division) }
  Then { team.should respond_to(:players) }
  Then { team.should respond_to(:draft) }
end
