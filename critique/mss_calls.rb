# wrapper for Rest.response, so that you don't have to keep entering the host and port for MSS:
# @param [Request]
# @return [Response]
def mss_rest_response(request)
  Rest.response(MSS_HOST, MSS_PORT, request)
end

# hit MSS' health-check endpoint to make sure your desired instance of MSS is up and running
# @return response code [String] if response is not '200'
def check_mss_status
  mc_trace_test "check_mss_status"
  req = Rest.get(MSS_VERSION, '/status')
  resp = mss_rest_response(req)
  Rest.validate_http_code('200', resp.code)
end

# add a subscriber to the MSS database
# @param subscriber [Subscriber] to be created in MSS database
# @return [Response] to MSS request
def add_subscriber(subscriber)
  mc_trace_test "add_subscriber #{subscriber.inspect}"
  req = Rest.post(MSS_VERSION, "/subscribers", subscriber.to_j)
  req['Content-Type']='text/json'
  mss_rest_response(req)
end

# delete a subscriber from MSS database
# @param subscriber_id [String; Integer] id of subscriber to delete
# @return [Response]
def delete_subscriber(subscriber_id)
  mc_trace_test "delete_subscriber #{subscriber_id}"
  req = Rest.delete(MSS_VERSION, "/subscribers/" + subscriber_id.to_s)
  mss_rest_response(req)
end

# call PUT to update a subscriber
# @param subscriber [Array] of hashes of Subscriber object(s)
# @param sub_id [Integer] subscriber id; normally supplied by subscriber object but may need to override
# @param payload [Hash] typically the subscriber object cast to JSON, but can be overridden
# @return [Response]
def update_subscriber(subscriber, sub_id=subscriber.id, payload=subscriber.to_j)
  mc_trace_test "update_subscriber #{subscriber.inspect}, #{sub_id}"
  req = Rest.put(MSS_VERSION, "/subscribers/#{sub_id.to_s}", payload)
  req['Content-Type']='text/json'
  mss_rest_response(req)
end

# query MSS for subscriber info to assert if subscriber exists
# @param subscriber_id [String] id of subscriber to query
# @return [Boolean]
def subscriber_list_includes?(subscriber_id)
  mc_trace_test "subscriber_list_includes? #{subscriber_id}"
  response = get_subscriber_info(subscriber_id)
  response.code == "200" ? true : false
end

# call GET to find a subscription for a subscriber / item
# @param subscriber [Subscriber] the subscriber to get the subscription
# @param item [Item] the item to get subscribed
# @return [Response]
def get_subscription(subscriber, item)
  mc_trace_test "get_subscription #{subscriber.inspect}, #{item.inspect}"
  req = Rest.get(MSS_VERSION, "/subscribers/#{subscriber.id.to_s}#{item.item_path}")
  mss_rest_response(req)
end

# call PUT to create a subscription
# @param subscriber [Subscriber] the subscriber to get the subscription
# @param item [Item] the item to get subscribed
# @return [Response]
def add_subscription(subscriber, item)
  mc_trace_test "add_subscription #{subscriber.inspect}, #{item.inspect}"
  #Rest.put expects a payload as its third argument; there is no payload in this case -it's all in the uri:
  req = Rest.put(MSS_VERSION, "/subscribers/#{subscriber.id.to_s}#{item.item_path}", '')
  mss_rest_response(req)
end

# call DELETE to remove a subscription for a subscriber / item
# @param subscriber [Subscriber] the subscriber to get the subscription
# @param item [Item] the item to get subscribed
# @return [Response]
def delete_subscription(subscriber, item)
  mc_trace_test "delete_subscription #{subscriber.inspect}, #{item.inspect}"
  req = Rest.delete(MSS_VERSION, "/subscribers/#{subscriber.id.to_s}#{item.item_path}")
  mss_rest_response(req)
end

# REST request for information about a given subscriber
# @param subscriber_id [String] id of subscriber to query
# @return [Response]
def get_subscriber_info(subscriber_id)
  mc_trace_test "get_subscriber_info #{subscriber_id}"
  req = Rest.get(MSS_VERSION, "/subscribers/" + subscriber_id.to_s)
  mss_rest_response(req)
end

# wrapper for get_item_subscribers_list_for
# @param subscriber_id [String] subscriber to query
# @param item [Item] item to check subscription on for given subscriber
# @return [Boolean]
def item_subscriber_list_includes?(subscriber_id, item)
  mc_trace_test "item_subscriber_list_includes? #{subscriber_id}, #{item.inspect}"
  item_subscribers_list = get_item_subscribers_list_for(item)
  item_subscribers_list.each do |subscriber|
    if subscriber.id == subscriber_id
      return true
    end
  end
  false
end

# pass in an Item object, get an array of Subscribers who are subscribed to that object
# @param item [Item] the item to query for its subscribers
# @return [Array] of subscribers
def get_item_subscribers_list_for(item)
  mc_trace_test "get_item_subscribers_list_for #{item.inspect}"
  req = Rest.get(MSS_VERSION, "/items#{item.item_path}/subscribers")
  response = mss_rest_response(req)
  body = JSON.parse(response.body)

  if response.code != '200'
    raise "I was expecting a 200 response, instead I got #{response.code}"
  end

  subscribers = []
  body.each do |subscriber|
    subscribers << make_subscriber(subscriber['id'], subscriber['name'], subscriber['broker_url'], subscriber['queue_name'])
  end
  subscribers
end

# delete all subscriptions for a given item
# @param item [Item] the item to get all of its subscriptions removed
# @return [String] response code if response code is not '204'
def unsubscribe_all_subscribers(item)
  mc_trace_test "unsubscribe_all_subscribers #{item.inspect}"
  req = Rest.delete(MSS_VERSION, "/items#{item.item_path}/subscribers")
  response = mss_rest_response(req)
  Rest.validate_http_code('204', response.code)
end
