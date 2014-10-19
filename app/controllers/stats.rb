Gamegit::App.controllers :stats do
  before do
    @period = params[:period]
    if @period && !StatsManager.is_period_supported?(@period)
      halt 503, "Only #{StatsManager::SUPPORTED_PERIODS.inspect} periods are supported."
    end
  end

  get :stats, "/stats/:period" do
    stats = Stats.where(_type: "Stats", period: /^#{@period}/).order_by(:period.asc).limit(12)
    angular_response 200, stats
  end

  get :user_stats, "/user_stats/:login/:period" do
    stats = Stats.where(_type: "UserStats", period: /^#{@period}/, login: params[:login]).order_by(:period.asc).limit(12)
    angular_response 200, stats
  end

end

