namespace :process do
  task events: [:environment]  do
    processor = EventProcessor.new(Event.events_to_process)
    processor.run
  end
end

