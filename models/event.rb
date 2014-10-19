class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type, type: String
  field :data, type: Hash
  field :image_url, type: String
  field :user_data, type: Hash, default: {}

  belongs_to :user

  validates_presence_of :type

  before_save :cache_user_data

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

