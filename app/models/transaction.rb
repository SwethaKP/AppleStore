require 'openssl'
require 'uri'
require 'net/http'
require 'json'
require 'rubygems'

class Transaction < Order

	def create_transaction(token, total, id, apple, orange)
		url = URI("https://sandbox-api.getsimpl.com/api/v1.1/transactions")

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		request = Net::HTTP::Post.new(url)
		request["authorization"] = 'dee038151ed952f12318d3355ddc35fb'
		request["content-type"] = 'application/json'

		req_body = {
			  transaction_token: token,
			  amount_in_paise: total,
			  order_id: id,
			  items: [{
				sku: "",
				quantity: apple,
				unit_price_in_paise: 2000,
				display_name: "apples"
			    },
			    {
			    sku: "",
				quantity: orange,
				unit_price_in_paise: 1500,
				display_name: "oranges"
			    }],
			  shipping_address: {
				line1: "Shipping line1",
				line2: "Shipping line2",
				city: "Mumbai",
				state: "Maharastra",
				pincode: "400072"
			  },
			  billing_address: {
				line1: "Shipping line1",
				line2: "Shipping line2",
				city: "Mumbai",
				state: "Maharastra",
				pincode:"400072"
			    },
			  shipping_amount_in_paise: 0,
			  discount_in_paise: 0,
			  metadata:[
			    {key1: ""},
			    {key2: ""}
			  ]
			}
		request.body = req_body.to_json
		response = http.request(request)
		return response.read_body
	end

end