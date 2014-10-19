Gamegit::App.controllers :sites do

  get :config do
    #site_id = params[:id].to_s
    #site = Site.where(id: site_id).first || Site.default
    angular_response 200, { name: ENV["SITE_NAME"] || "Gamegit" }
  end
end

