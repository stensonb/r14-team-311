class StatsManager
  SUPPORTED_PERIODS = %w[
    monthly
    weekly
  ]

  def self.is_period_supported?(period)
    SUPPORTED_PERIODS.include?(period.to_s)
  end

  def self.process_event(event)
    send(:"increment_#{event.type}_event_stats", event)
  rescue => e
    Padrino.logger.warn "Unhandled event type: #{event.type} when incrementing stats: #{e.message}"
  end

  def self.increment_push_event_stats(event)
    increment_stats(event.created_at, :pushes, event.data["sender"]["login"])

    event.data["commits"].each do |commit|
      increment_commit_event_stats(commit)
    end
  end

  def self.increment_commit_event_stats(commit)
    return unless commit["distinct"]

    date = Time.parse(commit["timestamp"])
    login = commit["author"]["username"] || commit["committer"]["username"]
    increment_stats(date, :commits, login)
  end

  def self.increment_issues_event_stats(event)
    date = Time.parse(event.data["created_at"]) rescue Time.now
    action = :"#{event.data["action"]}_issues"
    increment_stats(date, action, event.data["sender"]["login"])
  end

  def self.increment_pull_request_event_stats(event)
    date = Time.parse(event.data["created_at"]) rescue Time.now
    action = :"#{event.data["action"]}_pull_requests"
    increment_stats(date, action, event.data["sender"]["login"])
  end

  def self.increment_stats(date, key, login, count = 1)
    Stats.increment(date, key, count)
    UserStats.increment(login, date, key, count)
  end
end

