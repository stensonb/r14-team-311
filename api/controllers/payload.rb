Gamegit::App.controller :payload do

  helpers do
    def verify_signature(payload_body)
      signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), ENV['GAMEGIT_SECRET_TOKEN'], payload_body)
      return halt 500, "Signatures didn't match!" unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
    end
  end

  post "/" do
    request.body.rewind
    payload_body = request.body.read
    verify_signature(payload_body)

    event = Event.new
    event.data = params
    event.save
  end

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end

end
