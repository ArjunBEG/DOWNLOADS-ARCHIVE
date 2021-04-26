#!/bin/bash

## updating the jsons

pwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
artifactspath="$pwd/../_artifacts"
jsonpath="$pwd/../_json"
rootpath="$pwd/../.."

yarn update:sample-json --quiet && cp -f "$rootpath/lighthouse-core/test/results/sample_v2.json" "$jsonpath/dbwtester.json"

node "$pwd/generate_report.js" && echo "✅   dbwtester.html is refreshed. doing the rest." && echo "";

lighthouse --quiet --output=json -A="$artifactspath/errors" --output-path="$jsonpath/errors.json"
lighthouse --quiet --output=json -A="$artifactspath/solocat" --output-path="$jsonpath/solocat.json" --only-categories="performance"
lighthouse --quiet --output=json -A="$artifactspath/tinyhouse" --output-path="$jsonpath/tinyhouse.json"
lighthouse --quiet --output=json -A="$artifactspath/cnn" --output-path="$jsonpath/cnn.json"
lighthouse --quiet --output=json -A="$artifactspath/caltrain" --output-path="$jsonpath/caltrain.json"
lighthouse --quiet --output=json -A="$artifactspath/cnn" --output-path="$jsonpath/cnnXA.json" --locale=en-XA
lighthouse --quiet --output=json -A="$artifactspath/example" --output-path="$jsonpath/example.json"
lighthouse --quiet --output=json -A="$artifactspath/paulirish" --output-path="$jsonpath/paulirish.json"
lighthouse --quiet --output=json -A="$artifactspath/paulirish" --output-path="$jsonpath/paulirishXA.json" --locale=en-XA

node "$pwd/generate_report.js"
