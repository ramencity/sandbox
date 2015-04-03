require 'sinatra'
require 'json'

get "/status" do
  "Hey I am pretending to be MINA!"
end

post  "/mina/v5/batch/productsearch" do
  "Seller [MWSMerchantId] does not have access to the given marketplace [MWSMarketplaceId]"
end
