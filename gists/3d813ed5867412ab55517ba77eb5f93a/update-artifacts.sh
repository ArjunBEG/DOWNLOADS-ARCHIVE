#!/bin/bash

## updating the artifacts

set -x

# yarn update:sample-artifacts  # uncomment if you actually need to refresh the dbwtester files
lighthouse -G="./_reports/_artifacts/tinyhouse" https://tinyhousebuild.com
lighthouse -G="./_reports/_artifacts/cnn" http://cnn.com
lighthouse -G="./_reports/_artifacts/example" http://example.com
lighthouse -G="./_reports/_artifacts/paulirish" https://www.paulirish.com/
lighthouse -G="./_reports/_artifacts/caltrain" https://caltrainschedule.io/
