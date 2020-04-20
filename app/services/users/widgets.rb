class Users::Widgets < ActiveInteraction::Base

  string :token
  string :term, default: nil

  def execute
    url = "#{ENV['SHOWOFF_URL']}/api/v1/users/me/widgets"
    payload = {
        params: {
            client_id: ENV['CLIENT_ID'],
            client_secret: ENV['CLIENT_SECRET'],
            term: term
        },
        Authorization: "Bearer #{token}"
    }
    begin
      response = RestClient.get(url, payload)
      JSON.parse(response.body)
    rescue => e
      errors.add(:user_widgets, message: e.message)
    end
  end
end