# frozen_string_literal: true

module ActsAsApiService
  private

  def api_endpoint
    raise NotImplementedError
  end

  def api
    Faraday.new(url: api_endpoint)
  end

  def api_post(resource_path, options = {})
    response = api.post(resource_path, options)
    parse_response(response)
  end

  def parse_response(response)
    {
      status: response.status,
      body: JSON.parse(response.body)
    }
  end
end
