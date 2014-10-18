Gamegit::App.controllers :events do
  get :index, :map => '/events' do
    time = Time.at([params[:timestamp].to_i, 0].max)
    events = Event.order_by(:created_at.desc).where(:created_at.gte => time).limit(20)

    angular_response 200, events
  end
end
