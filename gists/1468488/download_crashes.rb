require "rubygems"
require "json"
require "open-uri"

puts "API Token:"
api_token = gets.strip

puts "App ID:"
app_id = gets.strip

puts "Crash Group ID:"
group_id = gets.strip

base_url = "https://rink.hockeyapp.net/api/2/apps/#{app_id}"
group_url = "#{base_url}/crash_reasons/#{group_id}"

group = JSON.parse(open(group_url, 'X-HockeyAppToken' => api_token).read)

group["total_pages"].times do |page|
  group["crashes"].each do |crash|
    id = crash["id"]
    system "curl -L -H \"X-HockeyAppToken: #{api_token}\" #{base_url}/crashes/#{id}?format=log > #{id}.log"
    puts "Downloaded crash log with ID #{id} to #{id}.log."
  end

  # page starts with zero, so +2 is the next page
  group = JSON.parse(open(group_url + "?page=#{page + 2}", 'X-HockeyAppToken' => api_token).read)
end
