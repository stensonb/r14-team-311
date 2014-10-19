Gamegit::Api.controller :payload do
  before do
    content_type :json
  end

  post :create, map: "/github" do
    payload_body = read_body_from_request
    verify_github_signature(payload_body)

    event = GithubEvent.build_from_payload(request.env, payload_body)

    if event.save!
      Thread.start do
        EventProcessor.process_events([event])
      end

      api_response 200
    end

    api_response 403
  end
end

