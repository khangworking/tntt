require 'net/http'

class FacebookGroupsService
  def self.publish(message)
    access_token = Setting.value_of('FACEBOOK_LONG_LIVED_ACCESS_TOKEN')
    return unless access_token

    uri = URI("https://graph.facebook.com/#{ENV['GROUP_ID']}/feed")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    headers = { 'Content-Type' => 'application/json' }
    request = Net::HTTP::Post.new("#{uri.path}?#{uri.query}", headers)
    request.body = {
      message: message,
      access_token: access_token
    }.to_json
    response = http.request(request)
    response.body
  end
end
