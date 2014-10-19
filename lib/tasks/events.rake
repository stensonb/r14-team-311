namespace :events do
  task process: [:environment]  do
    processor = EventProcessor.new(Event.events_to_process)
    processor.run
  end

  task reprocess: [:environment] do
    GithubEvent.update_all(processed: false)
    User.destroy_all
    Stats.destroy_all
    GithubEvent.all.map{|e| e.send(:assign_user); e.save }

    processor = EventProcessor.new(GithubEvent.events_to_process)
    processor.run
  end
end

