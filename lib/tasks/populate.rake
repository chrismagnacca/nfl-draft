namespace :db do
  desc 'Populate Database'
  task populate: :environment do
    import_teams
    import_players
    import_order
  end
end

require 'csv'

def import_teams
  CSV.foreach(File.dirname(__FILE__) + "/../data/teams.csv", headers: true) do |row|
    Team.create(
      name: row['Team Name'].strip,
      division: row['Division'].strip
    )
  end
end

def import_players
  CSV.foreach(File.dirname(__FILE__) + "/../data/players.csv", headers: true) do |row|
    Player.create(
      name: row['Player Name'].strip,
      position: row['Position'].strip
    )
  end
end

def import_order
  CSV.foreach(File.dirname(__FILE__) + "/../data/order.csv", headers: true) do |row|
    team_name = row['Team Name'].strip
    Draft.create(
      round: row['Round'],
      pick: row['Pick'],
      team_id: Team.where(name: handle_abbreviations(team_name)).first.id
    )
  end
end

def handle_abbreviations(team_name)
  team_name.gsub(/^NY/,'New York')
end


