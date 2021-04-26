tell application "Google Chrome"
	
	set tab_list to every tab in the front window
	
	repeat with the_tab in tab_list
		set the_url to the URL of the_tab
		tell application "Safari" to open location the_url
	end repeat
	
end tell