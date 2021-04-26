# First, remove all the folders in the npx cache location
# https://github.com/npm/cli/issues/1935#issuecomment-745561262
rm -rf $(npm get cache)/_npx/*