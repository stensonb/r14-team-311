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
    event.user.set(points + Event::POINTS[:push])
  end

  def process_ping_event(event)
    # TODO: Process event specific content action
    points = event.user.points
    event.user.set(points + Event::POINTS[:ping])
  end

  def process_issues_event(event)
    # TODO: Process event specific content action
    points = event.user.points
    event.user.set(points + Event::POINTS[:issues])
  end

  def process_create_event(event)
    # TODO: Process event specific content action
    points = event.user.points
    event.user.set(points + Event::POINTS[:create])
  end

  def process_pull_request_event(event)
    # TODO: Process event specific content action
    points = event.user.points
    event.user.set(points + Event::POINTS[:pull_request])
  end

end

