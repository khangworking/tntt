namespace :people do
  desc "Refresh the feast day years"
  task refreshes_feastyears: :environment do
    Person.where('feastday < CURRENT_DATE').update_all("feastday = (feastday + interval '1 year')")
  end

  desc "Send feast day congratulation"
  task send_feast_congratulation: :environment do
    Person.send_feastday_congratulation
  end
end
