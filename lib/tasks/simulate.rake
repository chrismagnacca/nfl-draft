desc 'Simulate the Draft'
task simulate: :environment do
  drafts = Draft.all
  drafts.each do |draft|
    player = Player.where(drafted: false).first
    Draft.current.team.acquire(player) if not Draft.current.nil?
  end
end

