Gamegit::App.controllers :events do
  before do
    Time.zone = ENV['GITGAME_TIMEZONE'] || 'UTC'
  end

  get :index, :map => '/events' do
    time = Time.zone.at([params[:timestamp].to_f, 0].max)
    events = Event.desc(:created_at).where(:created_at.gt => time).limit(20)

    angular_response 200, events
  end
end

