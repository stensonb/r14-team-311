namespace :events do
  task process: [:environment]  do
    processor = EventProcessor.new(Event.events_to_process)
    processor.run
  end

  task reprocess: [:environment] do
    Event.update_all(processed: false)
    User.update_all(points: 0)

    processor = EventProcessor.new(Event.events_to_process)
    processor.run
  end
end

