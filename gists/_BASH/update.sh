buildPlist=${INFOPLIST_FILE}
buildNumber=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" $buildPlist)
buildNumber=$(($buildNumber + 1))
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" $buildPlist