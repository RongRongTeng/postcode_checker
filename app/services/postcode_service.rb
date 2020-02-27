# frozen_string_literal: true

class PostcodeService
  extend ActsAsApiService

  class << self
    def lookup(postcodes)
      response = api_post('/postcodes', postcodes: postcodes)

      response.dig(:body, 'result').map do |result|
        input_postcode = result['query']
        is_availalbe = in_whitelist?(input_postcode) || result['result'].present?
        [input_postcode, is_availalbe]
      end
    end

    private

    def api_endpoint
      'https://api.postcodes.io'
    end

    def in_whitelist?(postcode)
      postcodes = PostcodeWhitelist.fetch_cache
      postcodes.include?(postcode.sub(/\s/, ''))
    end
  end
end
