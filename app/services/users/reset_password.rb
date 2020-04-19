class Users::ResetPassword < ActiveInteraction::Base

  hash :user do
    string :email
  end

  def execute
    url = "#{ENV['SHOWOFF_URL']}/api/v1/users/reset_password"
    payload = {
        client_id: ENV['CLIENT_ID'],
        client_secret: ENV['CLIENT_SECRET'],
        user: {
            email: user[:email]
        }
    }
    headers = {content_type: :json}
    begin
      response = RestClient.post(url, payload.to_json, headers)
      JSON.parse(response.body)
    rescue => e
      errors.add(:password, message: e.message)
    end
  end

end