Gamegit::Api.controller :payload do
  before do
    content_type :json
  end

  post :create, map: "/github" do
    request.body.rewind
    payload_body = request.body.read
    verify_signature(payload_body)

    event = Event.build_from_payload(request.env, payload_body)

    if event.save
      {success: true }.to_json
    else
      halt 403, {success: false}.to_json
    end
  end
end
