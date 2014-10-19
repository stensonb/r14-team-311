class GithubEvent < Event
  field :delivery_id, type: String
  field :processed, type: Boolean, default: false

  attr_accessible :delivery_id

  validates_presence_of :delivery_id

  scope :events_to_process, ->{ where(processed: false) }


  def self.build_from_payload(headers, payload_body)
    event = self.find_or_build_by_delivery_id(headers["HTTP_X_GITHUB_DELIVERY"])
    event.type = headers["HTTP_X_GITHUB_EVENT"]

    payload_json = JSON.parse(payload_body)
    event.data = payload_json
    event.find_user.save

    return event
  end

  def self.find_or_build_by_delivery_id(delivery_id)
    GithubEvent.where(delivery_id: delivery_id).first || GithubEvent.new(delivery_id: delivery_id)
  end

  def find_user
    self.user ||= User.find_or_build_from_json(self.data["sender"])
  end

end

