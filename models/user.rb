class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :login, type: String
  field :last_activity_at, type: Time
  field :points, type: Integer, default: 0
  field :level, type: Integer, default: 0

  def find_or_create_by_login(login)
    User.where(login: login).first || User.create(login: login)
  end
end

