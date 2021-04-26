#### here's how i quickly iterate across 10* diff reports at once

1. `mkdir -p _reports/_scripts/` folder in repo root
1. also do a `mkdir -p _reports/_json/`
1. add the below files into it

now you're setup for automation.

* run `bash _reports/_scripts/update-artifacts.sh` rarely. 
* run `bash _reports/_scripts/refresh-LHRs-from-artifacts.sh` when LHRs change shape

and the real thing:

* run `node _reports/_scripts/generate_report.js` all the time
    - i have [`entr`](http://entrproject.org/) installed and so i use this:
       - `ls lighthouse-core/report/**/* | entr node _reports/_scripts/generate_report.js`
       - this'll regen the report files everytime a file within report/ is modified.    
* then open up `_report/`, select all the .html files, and drag them onto your browser icon. that should open all 10 in diff tabs.

-----------------

_* okay really 5 unique ones. just slightly diff styling for the other 5. ;)_ 