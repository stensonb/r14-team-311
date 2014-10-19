class EventProcessor
  SUPPORTED_EVENTS = %w[
    push
    issues
    pull_request
  ]

  def initialize(events)
    @events = events
  end

  def run
    @events.each do |event|
      process_event(event)
    end
  end

  def supported_event?(event)
    SUPPORTED_EVENTS.include?(event.type)
  end

  def process_event(event)
    if supported_event?(event)
      PointsManager.process_event(event)
      StatsManager.process_event(event)
    else
      Padrino.logger.info "Event will not be processed: #{event.type}"
    end

    event.set(processed: true)
  end
end

