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
    # TODO
  end

  def process_ping_event(event)
    # TODO
  end

end

