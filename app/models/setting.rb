# == Schema Information
#
# Table name: settings
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  options    :text
#  value      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Setting < ApplicationRecord
  serialize :options, Hash

  class << self
    def value_of(name)
      find_by(name: name)&.value
    end

    def refresh_fb_token
      token = find_by(name: 'FACEBOOK_LONG_LIVED_ACCESS_TOKEN')
      return unless token
      return if token.options[:expired_date] && token.options[:expired_date] >= Time.zone.now.to_date

      params = {
        grant_type: 'fb_exchange_token',
        client_id: ENV['FACEBOOK_APP_ID'],
        client_secret: ENV['FACEBOOK_APP_SECRET'],
        fb_exchange_token: token.value
      }.map { |k,v| "#{k}=#{v}" }.join('&')
      uri = URI("https://graph.facebook.com/v12.0/oauth/access_token?#{params}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      headers = { 'Content-Type' => 'application/json' }
      request = Net::HTTP::Get.new("#{uri.path}?#{uri.query}", headers)
      response = http.request(request)
      response = JSON.parse(response.body)
      puts response
      return unless response['access_token']

      token
        .update!(value: response['access_token'], options: { expired_date: 55.days.from_now.to_date })
    end
  end

end
