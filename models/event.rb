class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  POINTS = {
    push:  1,
    issues: 1,
    create: 1,
    pull_request: 1
  }

  field :type, type: String
  field :delivery_id, type: String
  field :data, type: Hash
  field :processed, type: Boolean, default: false
  field :image_url, type: String
  field :user_data, type: Hash, default: {}

  belongs_to :user

  validates_presence_of :type, :delivery_id

  before_create :assign_user
  before_save :cache_user_data

  attr_accessible :delivery_id

  scope :events_to_process, ->{ where(processed: false) }

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

  private
  def assign_user
    self.user = User.find_or_build_from_json(self.data["sender"])
  end

  def cache_user_data
    return if self.user.nil?

    self.user_data = {
      avatar_url: self.user.avatar_url,
      url: self.user.url,
      login: self.user.login,
      points: self.user.points,
      level: self.user.level
    }
  end
end

