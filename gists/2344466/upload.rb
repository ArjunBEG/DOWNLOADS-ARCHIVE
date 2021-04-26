require 'rubygems'
require 'rest_client'

# Replace with your values
APP_ID = "APP_ID"
APP_NAME = "EXECUTABLE_NAME"
BUNDLE_ID = "BUNDLE_IDENTIFIER"
BUNDLE_VERSION = "BUNDLE_VERSION"

files = Dir.glob("*.crash")
files.each do |filename|
  log = File.new(filename).read

  data = /OS Version:\s+iPhone OS\s(.*)\(.*\)/.match(log)
  if !data.nil? and data.length > 1
    systemversion = data[1].strip
  else
    systemversion = ""
  end

  data = /Hardware Model:\s+(.*)/.match(log)
  if !data.nil? and data.length > 1
    platform = data[1].strip
  else
    platform = ""
  end
  
  xml = ""
  xml << "<crash>"
  xml << "<applicationname>" + APP_NAME + "</applicationname>"
  xml << "<bundleidentifier>" + BUNDLE_ID + "</bundleidentifier>"
  xml << "<systemversion>" + systemversion + "</systemversion>"
  xml << "<platform>" + platform + "</platform>"
  xml << "<senderversion>" + BUNDLE_VERSION + "</senderversion>"
  xml << "<version>" + BUNDLE_VERSION + "</version>"
  xml << "<log><![CDATA[" + log + "]]></log>"
  xml << "<contact>" + "Manual Upload" + "</contact>"
  xml << "<userid>" + "" + "</userid>"
  xml << "<description>" + "" + "</description>"
  xml << "</crash>"

  tempfile = Tempfile.new("crash")
  tempfile.write xml
  tempfile.rewind

  RestClient.post("https://rink.hockeyapp.net/api/2/apps/#{APP_ID}/crashes", :xml => tempfile)
end