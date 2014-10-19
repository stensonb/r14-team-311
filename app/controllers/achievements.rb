Gamegit::App.controllers :achievements do
  get :types, :map => '/achievements/types' do
    angular_response 200, AchievementsProcessor.achievements
  end
end
