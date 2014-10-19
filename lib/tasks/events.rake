namespace :events do
  task process: [:environment]  do
    EventProcessor.process_events(GithubEvent.events_to_process)
  end

  task process_old_events: [:environment] do
    events = GithubEvent.events_to_process.where(:created_at.lt => 10.minutes.ago)
    EventProcessor.process_events(events)
  end

  task reprocess: [:environment] do
    GithubEvent.update_all(processed: false)
    SystemEvent.destroy_all
    User.destroy_all
    Stats.destroy_all
    GithubEvent.all.map{|e| e.send(:find_user); e.save }

    EventProcessor.process_events(GithubEvent.events_to_process)
  end
end

