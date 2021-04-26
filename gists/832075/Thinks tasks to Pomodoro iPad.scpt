-- Things to Pomodoro App for iPad
-- This script asks Things for the currently selected todos
-- and generates a Pomodoro App for iPad compatible JSON file
-- for you to import in to the app (using Dropbox)
--
-- Created by Thomas on 2011-02-17
-- Inspired by Andreas on 2011-02-17
-- 


set estimateItems to {}

set JSONresult to ""
set JSONresults to {}
set JSONBeginning to "[
"
set JSONresult to ""
set JSONresults to {}
set JSONBeginning to "[
"
set JSONEnd to "]"
set JSONTaskBegin to "	{
"
set JSONTaskEstimate to "		\"estimate\":"
set JSONTaskEnd to "	}
"
set JSONTaskListEnd to "	},
"
set JSONTaskList to "		\"list\":0,
"
set JSONTaskTitle to "		\"title\":\""

set UserName to do shell script "whoami"
set JSONfilename to "/Users/" & UserName & "/Dropbox/Pomodoro/tasks.json"

set clipboardContent to ""

-- this routine displays a dialog where the user can set an estimate amount of pomodoros for each task on the clipboard
tell application "Things"
	repeat with aToDo in selected to dos
		if (project of aToDo) is not missing value then
			set todoDataRow to "" & ¬
				(name of project of aToDo) & ": " & ¬
				(name of aToDo) & tab
		else if (area of aToDo) is not missing value then
			set todoDataRow to "" & ¬
				(name of area of aToDo) & ": " & ¬
				(name of aToDo) & tab
		else
			set todoDataRow to "" & ¬
				(name of aToDo) & tab
		end if
		
		set estimateDialog to display dialog "Estimate: " & todoDataRow default answer ¬
			"2" buttons {"Cancel", "OK"} default button {"OK"}
		
		if (button returned of estimateDialog is "OK") and (text returned of estimateDialog is not "") then
			copy text returned of estimateDialog to the end of estimateItems
		else if (button returned of estimateDialog is "OK") and (text returned of estimateDialog is "") then
			set amount to "2" -- default estimate is 2
		else if (button returned of estimateDialog is "Cancel") then
			return
		end if
		
		set clipboardContent to clipboardContent & todoDataRow & "
"
	end repeat
end tell

set clipboardContentLines to (count paragraphs of clipboardContent) - 1 -- get count of lines on clipboard

-- now we're stitching everything together
repeat with i from 1 to clipboardContentLines
	if i is not equal to clipboardContentLines then -- last item needs to be handled differently. FU JSON!
		set end of JSONresults to JSONTaskBegin & ¬
			JSONTaskEstimate & (item i of estimateItems) & ",
" & ¬
			JSONTaskList & ¬
			JSONTaskTitle & trim(paragraph i of clipboardContent) & "\"
" & ¬
			JSONTaskListEnd
		
	else
		set end of JSONresults to JSONTaskBegin & ¬
			JSONTaskEstimate & (item i of estimateItems) & ",
" & ¬
			JSONTaskList & ¬
			JSONTaskTitle & trim(paragraph i of clipboardContent) & "\"
" & ¬
			JSONTaskEnd
		
	end if
end repeat

repeat with i from 1 to clipboardContentLines
	set JSONresult to JSONresult & (item i of JSONresults)
end repeat

set JSONresult to JSONBeginning & JSONresult & JSONEnd

-- move exisiting files to old
set JSONpattern to "/Users/" & UserName & "/Dropbox/Pomodoro/*.json"
set fileMove to do shell script "for i in $(" & JSONpattern & "); do mv $i $i.old; done"
do shell script fileMove

-- write the results
set cmd to "echo " & (quoted form of JSONresult as string) & " > " & JSONfilename -- yeah, i know i suck for not using applescript here.
--return cmd
do shell script cmd

-- helper method to remove trailing newline
on trim(someText)
	set result to text 1 thru -2 of someText
	return result
end trim