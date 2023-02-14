# Load packages
using DotEnv
using HTTP
using JSON

# Load .env file
cfg = DotEnv.config()

# Events endpoint
url = "https://api.nylas.com/events?notify_participants=true"

# Body of the call
payload = Dict("title" => "Learn Julia with Nylas",
                      "when" => Dict("start_time" => 1675868400, "end_time" => 1675870200),
                      "location" => "YOUR LOCATION",
                      "calendar_id" => cfg["CALENDAR_ID"],
                      "participants" =>  [ Dict("email" => "YOUR EMAIL",
                                                         "name" => "YOUR NAME")])

# Headers for authorization
headers = Dict(
    "Accept" => "application/json",
    "Content-Type"=> "application/json",
    "Authorization"=> "Bearer " * cfg["ACCESS_TOKEN"]
)

# Calling the endpoint
response = HTTP.post(url, headers, json(payload))
# Print the response of the call
print(response)
