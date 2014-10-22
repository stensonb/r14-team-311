class PointsManager
  POINTS = {
    commit: (ENV['COMMIT_POINTS'] || 5).to_i,
    opened_issue: (ENV['OPENED_ISSUE_POINTS'] || 1).to_i,
    closed_issue: (ENV['CLOSED_ISSUE_POINTS'] || 10).to_i,
    opened_pull_request: (ENV['OPENED_PULL_REQUEST_POINTS'] || 5).to_i,
    closed_pull_request: (ENV['CLOSED_PULL_REQUEST_POINTS'] || 10).to_i
  }

  def self.process_event(event)
    send(:"assign_#{event.type}_event_points", event)
  rescue => e
    Padrino.logger.warn "Unhandled event type: #{event.type} when assigning points: #{e.message}"
  end

  def self.assign_push_event_points(event)
    event.data["commits"].each do |commit|
      assign_commit_event_points(commit)
    end
  end

  def self.assign_commit_event_points(commit)
    return unless commit["distinct"]

    login = commit["author"]["username"]
    if login.nil?
      # In some cases github doesn't include the username
      login = commit["author"]["email"].split("@", 2).first
    end

    increment_points(login, :commit)
  end

  def self.assign_issues_event_points(event)
    action = :"#{event.data["action"]}_issue"
    increment_points(event.data["sender"]["login"], action)
  end

  def self.assign_pull_request_event_points(event)
    action = :"#{event.data["action"]}_pull_request"
    increment_points(event.data["sender"]["login"], action)
  end

  def self.increment_points(login_or_user, action)
    user = login_or_user
    if login_or_user.kind_of?(String)
      user = User.find_or_create_by_login(login_or_user)
    end

    points = POINTS[action] || 0
    Padrino.logger.info "Incrementing #{points} points to user #{login_or_user} for #{action} action"
    if user
      user.atomically do
        user.inc(points: points)
        user.set(last_activity_at: Time.now)
      end
      StatsManager.increment_stats(Time.now, :points, user.login, points)
    end
  end

end

