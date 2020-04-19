class Auth::Login < ActiveInteraction::Base

  string :username
  string :password

  def execute
    url = "#{ENV['SHOWOFF_URL']}/oauth/token"
    payload = {
                grant_type: 'password',
                client_id: ENV['CLIENT_ID'],
                client_secret: ENV['CLIENT_SECRET'],
                username: username,
                password: password
              }
    headers = {content_type: :json}
    begin
      response = RestClient.post(url, payload.to_json, headers)
      JSON.parse(response.body)
    rescue => e
      errors.add(:login, message: e.message)
    end
  end

end