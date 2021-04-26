<?php
/* Detects some common web bots */
function detectBot($USER_AGENT) {
    $crawlers_agents = strtolower('Bloglines subscriber|Dumbot|Sosoimagespider|QihooBot|FAST-WebCrawler|Superdownloads Spiderman|LinkWalker|msnbot|ASPSeek|WebAlta Crawler|Lycos|FeedFetcher-Google|Yahoo|YoudaoBot|AdsBot-Google|Googlebot|Scooter|Gigabot|Charlotte|eStyle|AcioRobot|GeonaBot|msnbot-media|Baidu|CocoCrawler|Google|Charlotte t|Yahoo! Slurp China|Sogou web spider|YodaoBot|MSRBOT|AbachoBOT|Sogou head spider|AltaVista|IDBot|Sosospider|Yahoo! Slurp|Java VM|DotBot|LiteFinder|Yeti|Rambler|Scrubby|Baiduspider|accoona');
    $crawlers = explode("|", $crawlers_agents);
    if(is_array($crawlers) {
        foreach($crawlers as $crawler) {
            if (strpos(strtolower($USER_AGENT), trim($crawler)) !== false) {
                return true;
            }
        }
    }
    return false;
}

//Usage:
if(detectBot($_SERVER['HTTP_USER_AGENT'])) {
    echo "You're A BOT";
} else {
    echo "You're NOT A BOT";
}
