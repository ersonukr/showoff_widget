class Auth::Logout < ActiveInteraction::Base

  string :token

  def execute
    url = "#{ENV['SHOWOFF_URL']}/oauth/revoke"
    payload = {
        grant_type: 'password',
        client_id: ENV['CLIENT_ID'],
        client_secret: ENV['CLIENT_SECRET'],
        token: token,
    }
    headers = {content_type: :json, Authorization: "Bearer #{token}"}
    begin
      response = RestClient.post(url, payload.to_json, headers)
      JSON.parse(response.body)
    rescue => e
      errors.add(:login, message: e.message)
    end
  end

end