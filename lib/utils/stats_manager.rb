class StatsManager
  def self.process_event(event)
    send(:"increment_#{event.type}_event_stats", event)
  rescue Exception => e
    Padrino.logger.warn "Unhandled event type: #{event.type} when incrementing stats: #{e.message}"
  end

  def self.increment_push_event_stats(event)
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
    action = :"#{event.data["action"]}_pull_request"
    increment_stats(date, action, event.data["sender"]["login"])
  end

  def self.increment_stats(date, key, login, count = 1)
    Stats.stats_for(date).inc(key => count)
    UserStats.stats_for(login, date).inc(key => count)
  end
end
