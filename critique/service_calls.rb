# wrapper for Rest.response, so that you don't have to keep entering the host and port for MSS:
# @param [Request]
# @return [Response]
def alots_rest_response(request)
  Rest.response(ALOTS_SERVER, ALOTS_PORT, request)
end

# call GET to ALOTS and get the response
# @param item [Item]
# @param timestamp [Time] default to now
# @return [Response]
def get_alots_item(item, timestamp=Time.new.utc)
  mc_trace_test "get_alots_item #{item.inspect}, #{timestamp}"
  get = Rest.get(ALOTS_VERSION, "/offers#{item.item_path}")
  get['Authorization'] = HawkAuth.new.alots_hawk_header('GET', item.item_path, 'offers')
  get['If-Modified-Since'] = timestamp.httpdate
  alots_rest_response(get)
end

# call DELETE to ALOTS and get the response
# @param item [Item]
# @return [Response]
def delete_alots_item(item)
  mc_trace_test "delete_alots_item #{item.inspect}"
  delete = Rest.delete(ALOTS_VERSION, "/offers#{item.item_path}")
  delete['Authorization'] = HawkAuth.new.alots_hawk_header('DELETE', item.item_path, 'offers')
  resp = alots_rest_response(delete)
  raise "Response was not 204, response was #{resp.code}" if resp.code != '204'
  resp
end

# call PUT to ALOTS and get the response
# @param item [Item]
# @param payload [JSON]
# @param timestamp [Time] default = now
# @return [Response]
def put_alots_item(item, payload, timestamp=Time.new.utc)
  mc_trace_test "put_alots_item #{item.inspect}, #{payload.inspect}, #{timestamp}"
  put = Rest.put(ALOTS_VERSION, "/offers#{item.item_path}", payload)
  put['Authorization'] = HawkAuth.new.alots_hawk_header('PUT', item.item_path, 'offers')
  put['Triggered-At'] = zulu_string_ms(timestamp)
  alots_rest_response(put)
end
