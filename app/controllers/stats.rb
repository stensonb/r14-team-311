Gamegit::App.controllers :stats do

  get :stats, "/stats/monthly" do
    stats = Stats.where(_type: "Stats").order_by(:period.asc).limit(12)
    angular_response 200, stats
  end

  get :user_stats, "/user_stats/:login/monthly" do
    stats = Stats.where(_type: "UserStats", login: params[:login]).order_by(:period.asc).limit(12)
    angular_response 200, stats
  end

end

