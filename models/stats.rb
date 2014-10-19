class Stats
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :period, type: String

  field :opened_issues, type: Integer, default: 0
  field :closed_issues, type: Integer, default: 0
  field :pushes, type: Integer, default: 0
  field :commits, type: Integer, default: 0
  field :opened_pull_requests, type: Integer, default: 0
  field :closed_pull_requests, type: Integer, default: 0
  field :points, type: Integer, default: 0

  attr_accessible :period

  def self.period_for_date(date, scope = :monthly)
    date.strftime("%Y%m")
  end

  def self.stats_for(date)
    period = period_for_date(date)
    find_or_create(period: period)
  end

  def self.find_or_create(query)
    stats = self.where(query).first
    unless stats
      stats = self.create(query)
    end
    stats
  end
end

