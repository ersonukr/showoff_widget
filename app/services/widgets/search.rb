class Widgets::Search < ActiveInteraction::Base

  string :term, default: nil

  def execute
    url = "#{ENV['SHOWOFF_URL']}/api/v1/widgets/visible"
    payload = {
        params: {
            client_id: ENV['CLIENT_ID'],
            client_secret: ENV['CLIENT_SECRET'],
            term: term
        }
    }
    begin
      response = RestClient.get(url, payload)
      JSON.parse(response.body)
    rescue => e
      errors.add(:password, message: e.message)
    end
  end
end