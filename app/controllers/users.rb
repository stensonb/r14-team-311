Gamegit::App.controllers :users do
  get :index, :map => '/users' do
    events = User.desc(:points).limit(20)
    angular_response 200, events
  end
end
