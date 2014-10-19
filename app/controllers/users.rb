Gamegit::App.controllers :users do
  get :index, :map => '/users' do
    users = User.desc(:points).limit(20)
    angular_response 200, users
  end
end
