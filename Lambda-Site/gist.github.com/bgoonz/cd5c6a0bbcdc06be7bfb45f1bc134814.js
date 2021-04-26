document.write('<link rel="stylesheet" href="https://github.githubassets.com/assets/gist-embed-b4e1b64ab37d0cf7698bb0c5008263fe.css">')
document.write('<div id=\"gist108014543\" class=\"gist\">\n    <div class=\"gist-file\">\n      <div class=\"gist-data\">\n        <div class=\"js-gist-file-update-container js-task-list-container file-box\">\n  <div id=\"file-walk-sh\" class=\"file my-2\">\n    \n  <div itemprop=\"text\" class=\"Box-body p-0 blob-wrapper data type-shell  \">\n      \n<table class=\"highlight tab-size js-file-line-container\" data-tab-size=\"8\" data-paste-markdown-skip>\n      <tr>\n        <td id=\"file-walk-sh-L1\" class=\"blob-num js-line-number\" data-line-number=\"1\"><\/td>\n        <td id=\"file-walk-sh-LC1\" class=\"blob-code blob-code-inner js-file-line\"><span class=\"pl-en\">file_specification<\/span>() {<\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L2\" class=\"blob-num js-line-number\" data-line-number=\"2\"><\/td>\n        <td id=\"file-walk-sh-LC2\" class=\"blob-code blob-code-inner js-file-line\">        FILE_NAME=<span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-s\"><span class=\"pl-pds\">\$(<\/span>basename <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\${entry}<\/span><span class=\"pl-pds\">&quot;<\/span><\/span><span class=\"pl-pds\">)<\/span><\/span><span class=\"pl-pds\">&quot;<\/span><\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L3\" class=\"blob-num js-line-number\" data-line-number=\"3\"><\/td>\n        <td id=\"file-walk-sh-LC3\" class=\"blob-code blob-code-inner js-file-line\">        DIR=<span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-s\"><span class=\"pl-pds\">\$(<\/span>dirname <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\${entry}<\/span><span class=\"pl-pds\">&quot;<\/span><\/span><span class=\"pl-pds\">)<\/span><\/span><span class=\"pl-pds\">&quot;<\/span><\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L4\" class=\"blob-num js-line-number\" data-line-number=\"4\"><\/td>\n        <td id=\"file-walk-sh-LC4\" class=\"blob-code blob-code-inner js-file-line\">        NAME=<span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\${FILE_NAME<span class=\"pl-k\">%<\/span>.<span class=\"pl-k\">*<\/span>}<\/span><span class=\"pl-pds\">&quot;<\/span><\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L5\" class=\"blob-num js-line-number\" data-line-number=\"5\"><\/td>\n        <td id=\"file-walk-sh-LC5\" class=\"blob-code blob-code-inner js-file-line\">        EXT=<span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\${FILE_NAME<span class=\"pl-k\">##*<\/span>.}<\/span><span class=\"pl-pds\">&quot;<\/span><\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L6\" class=\"blob-num js-line-number\" data-line-number=\"6\"><\/td>\n        <td id=\"file-walk-sh-LC6\" class=\"blob-code blob-code-inner js-file-line\">        SIZE=<span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-s\"><span class=\"pl-pds\">\$(<\/span>du -sh <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\${entry}<\/span><span class=\"pl-pds\">&quot;<\/span><\/span> <span class=\"pl-k\">|<\/span> cut -f1<span class=\"pl-pds\">)<\/span><\/span><span class=\"pl-pds\">&quot;<\/span><\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L7\" class=\"blob-num js-line-number\" data-line-number=\"7\"><\/td>\n        <td id=\"file-walk-sh-LC7\" class=\"blob-code blob-code-inner js-file-line\">\n<\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L8\" class=\"blob-num js-line-number\" data-line-number=\"8\"><\/td>\n        <td id=\"file-walk-sh-LC8\" class=\"blob-code blob-code-inner js-file-line\">        <span class=\"pl-c1\">printf<\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span>%*s<span class=\"pl-smi\">\${GRE}<\/span>%s<span class=\"pl-smi\">\${NCL}<\/span>\\n<span class=\"pl-pds\">&quot;<\/span><\/span>                    <span class=\"pl-s\"><span class=\"pl-pds\">\$((<\/span>indent<span class=\"pl-k\">+<\/span><span class=\"pl-c1\">4<\/span><span class=\"pl-pds\">))<\/span><\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&#39;<\/span><span class=\"pl-pds\">&#39;<\/span><\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\${entry}<\/span><span class=\"pl-pds\">&quot;<\/span><\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L9\" class=\"blob-num js-line-number\" data-line-number=\"9\"><\/td>\n        <td id=\"file-walk-sh-LC9\" class=\"blob-code blob-code-inner js-file-line\">        <span class=\"pl-c1\">printf<\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span>%*s\\tFile name:\\t<span class=\"pl-smi\">\${YEL}<\/span>%s<span class=\"pl-smi\">\${NCL}<\/span>\\n<span class=\"pl-pds\">&quot;<\/span><\/span>      <span class=\"pl-s\"><span class=\"pl-pds\">\$((<\/span>indent<span class=\"pl-k\">+<\/span><span class=\"pl-c1\">4<\/span><span class=\"pl-pds\">))<\/span><\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&#39;<\/span><span class=\"pl-pds\">&#39;<\/span><\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\$FILE_NAME<\/span><span class=\"pl-pds\">&quot;<\/span><\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L10\" class=\"blob-num js-line-number\" data-line-number=\"10\"><\/td>\n        <td id=\"file-walk-sh-LC10\" class=\"blob-code blob-code-inner js-file-line\">        <span class=\"pl-c1\">printf<\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span>%*s\\tDirectory:\\t<span class=\"pl-smi\">\${YEL}<\/span>%s<span class=\"pl-smi\">\${NCL}<\/span>\\n<span class=\"pl-pds\">&quot;<\/span><\/span>      <span class=\"pl-s\"><span class=\"pl-pds\">\$((<\/span>indent<span class=\"pl-k\">+<\/span><span class=\"pl-c1\">4<\/span><span class=\"pl-pds\">))<\/span><\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&#39;<\/span><span class=\"pl-pds\">&#39;<\/span><\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\$DIR<\/span><span class=\"pl-pds\">&quot;<\/span><\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L11\" class=\"blob-num js-line-number\" data-line-number=\"11\"><\/td>\n        <td id=\"file-walk-sh-LC11\" class=\"blob-code blob-code-inner js-file-line\">        <span class=\"pl-c1\">printf<\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span>%*s\\tName only:\\t<span class=\"pl-smi\">\${YEL}<\/span>%s<span class=\"pl-smi\">\${NCL}<\/span>\\n<span class=\"pl-pds\">&quot;<\/span><\/span>      <span class=\"pl-s\"><span class=\"pl-pds\">\$((<\/span>indent<span class=\"pl-k\">+<\/span><span class=\"pl-c1\">4<\/span><span class=\"pl-pds\">))<\/span><\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&#39;<\/span><span class=\"pl-pds\">&#39;<\/span><\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\$NAME<\/span><span class=\"pl-pds\">&quot;<\/span><\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L12\" class=\"blob-num js-line-number\" data-line-number=\"12\"><\/td>\n        <td id=\"file-walk-sh-LC12\" class=\"blob-code blob-code-inner js-file-line\">        <span class=\"pl-c1\">printf<\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span>%*s\\tExtension:\\t<span class=\"pl-smi\">\${YEL}<\/span>%s<span class=\"pl-smi\">\${NCL}<\/span>\\n<span class=\"pl-pds\">&quot;<\/span><\/span>      <span class=\"pl-s\"><span class=\"pl-pds\">\$((<\/span>indent<span class=\"pl-k\">+<\/span><span class=\"pl-c1\">4<\/span><span class=\"pl-pds\">))<\/span><\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&#39;<\/span><span class=\"pl-pds\">&#39;<\/span><\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\$EXT<\/span><span class=\"pl-pds\">&quot;<\/span><\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L13\" class=\"blob-num js-line-number\" data-line-number=\"13\"><\/td>\n        <td id=\"file-walk-sh-LC13\" class=\"blob-code blob-code-inner js-file-line\">        <span class=\"pl-c1\">printf<\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span>%*s\\tFile size:\\t<span class=\"pl-smi\">\${YEL}<\/span>%s<span class=\"pl-smi\">\${NCL}<\/span>\\n<span class=\"pl-pds\">&quot;<\/span><\/span>      <span class=\"pl-s\"><span class=\"pl-pds\">\$((<\/span>indent<span class=\"pl-k\">+<\/span><span class=\"pl-c1\">4<\/span><span class=\"pl-pds\">))<\/span><\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&#39;<\/span><span class=\"pl-pds\">&#39;<\/span><\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\$SIZE<\/span><span class=\"pl-pds\">&quot;<\/span><\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L14\" class=\"blob-num js-line-number\" data-line-number=\"14\"><\/td>\n        <td id=\"file-walk-sh-LC14\" class=\"blob-code blob-code-inner js-file-line\">}<\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L15\" class=\"blob-num js-line-number\" data-line-number=\"15\"><\/td>\n        <td id=\"file-walk-sh-LC15\" class=\"blob-code blob-code-inner js-file-line\">\n<\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L16\" class=\"blob-num js-line-number\" data-line-number=\"16\"><\/td>\n        <td id=\"file-walk-sh-LC16\" class=\"blob-code blob-code-inner js-file-line\"><span class=\"pl-en\">walk<\/span>() {<\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L17\" class=\"blob-num js-line-number\" data-line-number=\"17\"><\/td>\n        <td id=\"file-walk-sh-LC17\" class=\"blob-code blob-code-inner js-file-line\">        <span class=\"pl-k\">local<\/span> indent=<span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\${2<span class=\"pl-k\">:-<\/span>0}<\/span><span class=\"pl-pds\">&quot;<\/span><\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L18\" class=\"blob-num js-line-number\" data-line-number=\"18\"><\/td>\n        <td id=\"file-walk-sh-LC18\" class=\"blob-code blob-code-inner js-file-line\">        <span class=\"pl-c1\">printf<\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span>\\n%*s<span class=\"pl-smi\">\${RED}<\/span>%s<span class=\"pl-smi\">\${NCL}<\/span>\\n\\n<span class=\"pl-pds\">&quot;<\/span><\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\$indent<\/span><span class=\"pl-pds\">&quot;<\/span><\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&#39;<\/span><span class=\"pl-pds\">&#39;<\/span><\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\$1<\/span><span class=\"pl-pds\">&quot;<\/span><\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L19\" class=\"blob-num js-line-number\" data-line-number=\"19\"><\/td>\n        <td id=\"file-walk-sh-LC19\" class=\"blob-code blob-code-inner js-file-line\">        <span class=\"pl-c\"><span class=\"pl-c\">#<\/span> If the entry is a file do some operations<\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L20\" class=\"blob-num js-line-number\" data-line-number=\"20\"><\/td>\n        <td id=\"file-walk-sh-LC20\" class=\"blob-code blob-code-inner js-file-line\">        <span class=\"pl-k\">for<\/span> <span class=\"pl-smi\">entry<\/span> <span class=\"pl-k\">in<\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\$1<\/span><span class=\"pl-pds\">&quot;<\/span><\/span>/<span class=\"pl-k\">*<\/span><span class=\"pl-k\">;<\/span> <span class=\"pl-k\">do<\/span> [[ <span class=\"pl-k\">-f<\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\$entry<\/span><span class=\"pl-pds\">&quot;<\/span><\/span> ]] <span class=\"pl-k\">&amp;&amp;<\/span> file_specification<span class=\"pl-k\">;<\/span> <span class=\"pl-k\">done<\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L21\" class=\"blob-num js-line-number\" data-line-number=\"21\"><\/td>\n        <td id=\"file-walk-sh-LC21\" class=\"blob-code blob-code-inner js-file-line\">        <span class=\"pl-c\"><span class=\"pl-c\">#<\/span> If the entry is a directory call walk() == create recursion<\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L22\" class=\"blob-num js-line-number\" data-line-number=\"22\"><\/td>\n        <td id=\"file-walk-sh-LC22\" class=\"blob-code blob-code-inner js-file-line\">        <span class=\"pl-k\">for<\/span> <span class=\"pl-smi\">entry<\/span> <span class=\"pl-k\">in<\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\$1<\/span><span class=\"pl-pds\">&quot;<\/span><\/span>/<span class=\"pl-k\">*<\/span><span class=\"pl-k\">;<\/span> <span class=\"pl-k\">do<\/span> [[ <span class=\"pl-k\">-d<\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\$entry<\/span><span class=\"pl-pds\">&quot;<\/span><\/span> ]] <span class=\"pl-k\">&amp;&amp;<\/span> walk <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\$entry<\/span><span class=\"pl-pds\">&quot;<\/span><\/span> <span class=\"pl-s\"><span class=\"pl-pds\">\$((<\/span>indent<span class=\"pl-k\">+<\/span><span class=\"pl-c1\">4<\/span><span class=\"pl-pds\">))<\/span><\/span><span class=\"pl-k\">;<\/span> <span class=\"pl-k\">done<\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L23\" class=\"blob-num js-line-number\" data-line-number=\"23\"><\/td>\n        <td id=\"file-walk-sh-LC23\" class=\"blob-code blob-code-inner js-file-line\">}<\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L24\" class=\"blob-num js-line-number\" data-line-number=\"24\"><\/td>\n        <td id=\"file-walk-sh-LC24\" class=\"blob-code blob-code-inner js-file-line\">\n<\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L25\" class=\"blob-num js-line-number\" data-line-number=\"25\"><\/td>\n        <td id=\"file-walk-sh-LC25\" class=\"blob-code blob-code-inner js-file-line\"><span class=\"pl-c\"><span class=\"pl-c\">#<\/span> If the path is empty use the current, otherwise convert relative to absolute; Exec walk()<\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L26\" class=\"blob-num js-line-number\" data-line-number=\"26\"><\/td>\n        <td id=\"file-walk-sh-LC26\" class=\"blob-code blob-code-inner js-file-line\">[[ <span class=\"pl-k\">-z<\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\${1}<\/span><span class=\"pl-pds\">&quot;<\/span><\/span> ]] <span class=\"pl-k\">&amp;&amp;<\/span> ABS_PATH=<span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\${PWD}<\/span><span class=\"pl-pds\">&quot;<\/span><\/span> <span class=\"pl-k\">||<\/span> <span class=\"pl-c1\">cd<\/span> <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\${1}<\/span><span class=\"pl-pds\">&quot;<\/span><\/span> <span class=\"pl-k\">&amp;&amp;<\/span> ABS_PATH=<span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\${PWD}<\/span><span class=\"pl-pds\">&quot;<\/span><\/span><\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L27\" class=\"blob-num js-line-number\" data-line-number=\"27\"><\/td>\n        <td id=\"file-walk-sh-LC27\" class=\"blob-code blob-code-inner js-file-line\">walk <span class=\"pl-s\"><span class=\"pl-pds\">&quot;<\/span><span class=\"pl-smi\">\${ABS_PATH}<\/span><span class=\"pl-pds\">&quot;<\/span><\/span>      <\/td>\n      <\/tr>\n      <tr>\n        <td id=\"file-walk-sh-L28\" class=\"blob-num js-line-number\" data-line-number=\"28\"><\/td>\n        <td id=\"file-walk-sh-LC28\" class=\"blob-code blob-code-inner js-file-line\"><span class=\"pl-c1\">echo<\/span>               <\/td>\n      <\/tr>\n<\/table>\n\n\n  <\/div>\n\n  <\/div>\n<\/div>\n\n      <\/div>\n      <div class=\"gist-meta\">\n        <a href=\"https://gist.github.com/bgoonz/cd5c6a0bbcdc06be7bfb45f1bc134814/raw/aee7e4a21b1e860497d92b4b4a2a11b82fa0283e/walk.sh\" style=\"float:right\">view raw<\/a>\n        <a href=\"https://gist.github.com/bgoonz/cd5c6a0bbcdc06be7bfb45f1bc134814#file-walk-sh\">walk.sh<\/a>\n        hosted with &#10084; by <a href=\"https://github.com\">GitHub<\/a>\n      <\/div>\n    <\/div>\n<\/div>\n')
