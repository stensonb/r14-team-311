Gamegit::Api.helpers do
  def read_body_from_request
    request.body.rewind
    return request.body.read
  end

  def api_response(code, content = {})
    content[:success] = (code == 200)
    halt code, {'Content-Type' => "application/json"}, content.to_json
  end
end

