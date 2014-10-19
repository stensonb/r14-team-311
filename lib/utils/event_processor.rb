class EventProcessor

  def initialize(events)
    @events = events
  end

  def run
    @events.each do |event|
      process_event(event)
    end
  end

  def process_event(event)
    send(:"process_#{event.type}_event", event)
  rescue Exception => e
    Padrino.logger.error "Error processing event: #{event.delivery_id} (#{event.type}): #{e.message}\n\t#{e.backtrace.join("\n\t")}"
  end

  private
  def process_push_event(event)
    # TODO: Process event specific content action
    points = event.user.points
    event.user.inc(points: Event::POINTS[:push])
    Stats.current_stats.inc(opened_issues: 1)
  end

  def process_ping_event(event)
    # TODO: Process event specific content action
    points = event.user.points
    event.user.inc(points: Event::POINTS[:ping])
  end

  def process_issues_event(event)
    # TODO: Process event specific content action
    points = event.user.points
    event.user.inc(points: Event::POINTS[:issues])

    action = event.data["action"]
    if action == "opened"
      Stats.current_stats.inc(opened_issues: 1)
    elsif action == "closed"
      Stats.current_stats.inc(closed_issues: 1)
    end
  end

  def process_create_event(event)
    # TODO: Process event specific content action
    points = event.user.points
    event.user.inc(points: Event::POINTS[:create])
  end

  def process_pull_request_event(event)
    # TODO: Process event specific content action
    points = event.user.points
    event.user.inc(points: Event::POINTS[:pull_request])

    action = event.data["action"]
    if action == "opened"
      Stats.current_stats.inc(opened_pull_requests: 1)
    elsif action == "closed"
      Stats.current_stats.inc(closed_pull_requests: 1)
    end
  end

end

