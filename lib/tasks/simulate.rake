desc 'Simulate the Draft'
task simulate_draft: :environment do
  drafts = Draft.all
  drafts.each do |draft|
    draft.assign_player
  end
end

