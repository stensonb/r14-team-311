class PointsManager
  POINTS = {
    commit: 1,
    opened_issue: 1,
    closed_issue: 1,
    opened_pull_request: 1,
    closed_pull_request: 1
  }

  def self.assign_points(event)
    send(:"assign_#{event.type}_event_points", event)
  rescue Exception => e
    Padrino.logger.warn "Unhandled event type: #{event.type} when assigning points."
  end

  def self.assign_push_event_points(event)
    event.data["commits"].each do |commit|
      assign_commit_event_points(commit)
    end
  end

  def self.assign_commit_event_points(commit)
    return unless commit["distinct"]

    increment_points(commit["author"]["username"], :commit)
  end

  def self.assign_issues_event_points(event)
    action = :"#{event.action}_issue"
    increment_points(event.user, action)
  end

  def self.assign_pull_request_event_points(event)
    action = :"#{event.action}_pull_request"
    increment_points(event.user, action)
  end

  def self.increment_points(login_or_user, action)
    user = login_or_user
    if login_or_user.kind_of?(String)
      user = User.find_or_create_by_login(login_or_user)
    end

    points = POINTS[action] || 0

    Padrino.logger.info "Incrementing #{points} points to user #{user.login} for #{action} action"
    user.inc(points: action)
  end
end

