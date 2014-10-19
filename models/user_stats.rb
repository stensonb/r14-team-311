class UserStats < Stats
  field :login, type: String

  attr_accessible :login

  validates_presence_of :login

  def self.stats_for(login, date)
    period = period_for_date(date)
    query = {period: period, login: login}

    find_or_create(query)
  end

end

