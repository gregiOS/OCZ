
#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Use this script passing SRCROOT and BUNDLE_IDENTIFIER"
    exit 1
fi
SRC_ROOT=$1
BUNDLE_IDENTIFIER=$2

if [ "$BUNDLE_IDENTIFIER" == "com.gp.OCZ-stage" ]; then
    BASE_URL="https://ocz-stage.com"
elif [ "$BUNDLE_IDENTIFIER" == "com.gp.OCZ" ]; then
    BASE_URL="https://ocz.com"
else
	echo "Unrecognized BUNDLE_IDENTIFIER!"
	exit 1
fi

OUTPUT=$(printf "//This file was generated using make_app_info.sh script inside pre-build action.\n\
// Please do not edit\n\n\
import Foundation\n\n\
struct AppInfo {\n\
   let baseURL: String\n\
   let appBundle: String\n\n\
   static let current = AppInfo(baseURL: \"$BASE_URL\", appBundle: \"$BUNDLE_IDENTIFIER\")\n\
}")
echo "$OUTPUT" > "$SRC_ROOT/OCZ/Configuration/AppInfo.swift"
