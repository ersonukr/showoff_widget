class Users::Registration < ActiveInteraction::Base

  hash :user do
    string :first_name
    string :last_name
    string :password
    string :email
    string :image_url, default: 'https://static.thenounproject.com/png/961-200.png'
  end

  def execute
    url = "#{ENV['SHOWOFF_URL']}/api/v1/users"
    payload = {
                client_id: ENV['CLIENT_ID'],
                client_secret: ENV['CLIENT_SECRET'],
                user: {
                    first_name: user[:first_name],
                    last_name: user[:last_name],
                    password: user[:password],
                    email: user[:email],
                    image_url: user[:image_url]
                }
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