class EventProcessor
  SUPPORTED_EVENTS = %w[
    push
    issues
    pull_request
  ]

  def self.process_events(events)
    processor = EventProcessor.new(events)
    processor.run
  end

  def initialize(events)
    @events = events
  end

  def run
    users_to_process = Set.new
    @events.each do |event|
      process_event(event)
      users_to_process.add(event.user)
    end

    award_achievements(users_to_process)
  end

  def award_achievements(users)
    achievement_processor = AchievementsProcessor.new(users)
    achievement_processor.run
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

