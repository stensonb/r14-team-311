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

  attr_accessible :period

  def self.current_stats
    code = DateTime.now.strftime("%m%Y")
    stats = Stats.where(period: code).first
    unless stats
      stats = Stats.new(period: code)
    end
    stats
  end
end

