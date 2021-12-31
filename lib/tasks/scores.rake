namespace :scores do
  desc "Add presence scores to all level in Monday"
  task presence_scores: :environment do
    if Time.zone.now.monday?
      PeoplePresence.process_score_cells
    end
  end
end
