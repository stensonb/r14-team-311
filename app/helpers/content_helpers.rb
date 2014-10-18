Gamegit::App.helpers do
  def angular_response(code, content)
    halt code, headers_for_angular, normalize_content_for_angular(content)
  end

  def headers_for_angular
    headers = {
      "Content-Type" => "application/json"
    }

    if Padrino.env == :development
      # Allow XSS in development.
      headers["Access-Control-Allow-Origin"] = "*"
    end

    headers
  end

  def normalize_content_for_angular(content)
    response = {}

    response["data"] = content.as_json
    response["metadata"] = get_metadata_for_response(response["data"])

    response.to_json
  end

  def get_metadata_for_response(response)
    {
      count: response.respond_to?(:to_a) ? response.to_a.count : 1,
      page: params[:page] || 1,
      per_page: [params[:per_page].to_i, 20].max
    }
  end
end
