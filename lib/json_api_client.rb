class JsonApiClient
  protected

    def fetch_json_from_url(url)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      raise "HTTP request returned with bad status: #{response.code}" unless response.code == "200"
      return ActiveSupport::JSON.decode(response.body)
    end
end