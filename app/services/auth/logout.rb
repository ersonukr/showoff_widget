class Auth::Logout < ActiveInteraction::Base

  string :token

  def execute
    url = "#{ENV['SHOWOFF_URL']}/oauth/revoke"
    payload = {token: token}
    headers = {content_type: :json, Authorization: "Bearer #{token}"}
    begin
      response = RestClient.post(url, payload.to_json, headers)
      JSON.parse(response.body)
    rescue => e
      errors.add(:logout, message: e.message)
    end
  end

end