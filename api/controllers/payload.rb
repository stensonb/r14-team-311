Gamegit::Api.controller :payload do
  before do
    content_type :json
  end

  helpers do
    def verify_signature(payload_body)
      signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), ENV['GAMEGIT_SECRET_TOKEN'].to_s, payload_body)
      return halt 500, {error: "Signatures didn't match!"}.to_json unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'].to_s)
    end
  end

  post :create, map: "/github" do
    request.body.rewind
    payload_body = request.body.read
    verify_signature(payload_body)

    Padrino.logger.info "Received github event: #{payload_body.inspect}"
    event = Event.new
    event.data = params

    if event.save
      {success: true }.to_json
    else
      halt 403, {success: false}.to_json
    end
  end
end
