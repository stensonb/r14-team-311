Gamegit::Api.helpers do
  def verify_github_signature(payload_body)
    signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), ENV['GAMEGIT_SECRET_TOKEN'].to_s, payload_body)
    return halt 500, {error: "Signatures didn't match!"}.to_json unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'].to_s)
  end
end

