class Rest

  # create a GET request to an endpoint
  # @param api_version [String]
  # @param uri [String]
  # @return [Request]
  def self.get(api_version, uri)
    Net::HTTP::Get.new "/#{api_version}#{uri}"
  end

  # create a POST request to an endpoint
  # @param api_version [String]
  # @param uri [String]
  # @param payload [Object]
  # @return [Request]
  def self.post(api_version, uri, payload='')
    post = Net::HTTP::Post.new "/#{api_version}#{uri}"
    post.body = payload
    post
  end

  # create a PUT request to an endpoint
  # @param api_version [String]
  # @param uri [String]
  # @param payload [Object]
  # @return [Request]
  def self.put(api_version, uri, payload='')
    put = Net::HTTP::Put.new "/#{api_version}#{uri}"
    put.body = payload
    put
  end

  # create a DELETE request to an endpoint
  # @param api_version [String]
  # @param uri [String]
  # @return [Request]
  def self.delete(api_version, uri)
    Net::HTTP::Delete.new "/#{api_version}#{uri}"
  end

  # send an http request
  # @param host [String]
  # @param port [String]
  def self.response(host, port, request)
    client = Net::HTTP.start(host, port)
    client.request(request)
  end

  # get a hash of the headers returned in a REST response
  # @param [Response]
  # @return [Hash] of response headers
  def self.get_headers_for(response)
    h = response.to_hash
    # values are returned as an array; let's make them strings!
    Hash[h.map {|k, v| [k, v.join("")] } ]
  end

  # compare an expected http response code with the one you actually got
  # @param expected [String] response code
  # @param actual [String] response code
  def self.validate_http_code(expected, actual)
    unless expected == actual
      raise "I was expecting http status code of #{expected}, instead I got #{actual}"
    end
  end

end #Rest class

