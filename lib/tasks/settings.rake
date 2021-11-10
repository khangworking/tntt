namespace :settings do
  desc "Refresh the facebook user access token"
  task refreshes_token: :environment do
    Setting.refresh_fb_token
  end
end
