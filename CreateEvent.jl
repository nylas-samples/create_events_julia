# Load packages
using DotEnv
using HTTP
using JSON
using Dates
using TimeZones

# Load .env file
cfg = DotEnv.config()

# Events endpoint
url = "https://api.us.nylas.com/v3/grants/" * cfg["CALENDAR_ID"] * "/events?calendar_id=" * cfg["CALENDAR_ID"]

# Define the start and end times. Take the timezone into account when converting it to an Epoch
start_time = round(Int, datetime2unix(DateTime(ZonedDateTime(year(today()),month(today()),day(today()),14,0,0, localzone()),UTC)))
end_time = round(Int, datetime2unix(DateTime(ZonedDateTime(year(today()),month(today()),day(today()),15,0,0, localzone()),UTC)))

# Body of the call
payload = Dict("title" => "Learn Julia with Nylas",
                      "when" => Dict("start_time" => start_time, 
                                             "end_time" => end_time),
                      "location" => "Blag\'s Den",
                      "calendar_id" => cfg["CALENDAR_ID"],
                      "participants" =>  [ Dict("email" => cfg["GUEST_EMAIL"],
                                                         "name" => cfg["GUEST_NAME"])])

# Headers for authorization
headers = Dict(
    "Accept" => "application/json",
    "Content-Type"=> "application/json",
    "Authorization"=> "Bearer " * cfg["API_KEY_V3"]
)

#print(payload)

# Calling the endpoint
response = HTTP.post(url, headers, json(payload))
# Print the response of the call
print(response)
