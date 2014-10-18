class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type, type: String
  field :delivery_id, type: String
  field :data, type: Hash
  field :processed, type: Boolean, default: false

  validates_presence_of :type, :delivery_id

  attr_accessible :delivery_id

  def self.build_from_payload(headers, payload_body)
    event = self.find_or_build_by_delivery_id(headers["HTTP_X_GITHUB_DELIVERY"])
    event.type = headers["HTTP_X_GITHUB_EVENT"]

    payload_json = JSON.parse(payload_body)
    event.data = payload_json

    return event
  end

  def self.find_or_build_by_delivery_id(delivery_id)
    Event.where(delivery_id: delivery_id).first || Event.new(delivery_id: delivery_id)
  end
end
