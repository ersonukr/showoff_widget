class Widgets::Create < ActiveInteraction::Base

  string :token
  hash :widget do
    string :name
    string :description
    string :kind
  end

  def execute
    url = "#{ENV['SHOWOFF_URL']}/api/v1/widgets"
    payload = {
        widget: {
            name: widget[:name],
            description: widget[:description],
            kind: widget[:kind]
        }
    }
    headers = {content_type: :json, Authorization: "Bearer #{token}"}
    begin
      response = RestClient.post(url, payload.to_json, headers)
      JSON.parse(response.body)
    rescue => e
      errors.add(:create, message: e.message)
    end
  end
end