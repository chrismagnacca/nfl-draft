desc 'Simulate the Draft'
task simulate_draft: :environment do
  drafts = Draft.all
  drafts.each do |draft|
    player = Player.where(drafted: false).first
    Draft.current.team.acquire(player)
  end
end

