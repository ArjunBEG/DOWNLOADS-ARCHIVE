require "json"
require "rest-client"

# Replace with your values
APP_ID = "APP_ID"
API_TOKEN = "API_TOKEN" # Needs rw rights
BASE_URL = "https://rink.hockeyapp.net/api/2/apps/"

response = RestClient.get "#{BASE_URL}#{APP_ID}/app_versions", {"X-HockeyAppToken" => API_TOKEN}
app_versions = JSON.parse(response)
if app_versions["app_versions"].length > 0
  puts sprintf("%-10s %10s %10s %10s %25s", 
      "Version", 
      "Downloads",
      "Installs",
      "Usage Time",
      "Last Request At"
      )
end

app_versions["app_versions"].each do |app_version|
  begin
    id = app_version["id"]
    response = RestClient.get "#{BASE_URL}#{APP_ID}/app_versions/#{id}/statistics", {"X-HockeyAppToken" => API_TOKEN}
    statistics = JSON.parse(response)
    if statistics["status"] == "success"
      puts sprintf("%-10s %10d %10d %10s %25s", 
        app_version["version"], 
        statistics["statistics"]["downloads"],
        statistics["statistics"]["installs"],
        statistics["statistics"]["usage_time"],
        statistics["statistics"]["last_request_at"]
        )
    else
      puts sprintf("%-10s %10s", app_version["version"], "no stats")
    end
  rescue
    puts sprintf("%-10s %10s", app_version["version"], "error")
  end
end