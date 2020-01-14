
#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Use this script passing SRCROOT and BUNDLE_IDENTIFIER"
    exit 1
fi
SRC_ROOT=$1
BUNDLE_IDENTIFIER=$2

if [ "$BUNDLE_IDENTIFIER" == "com.gp.OCZ-stage" ]; then
	IMPORTS="import Foundation\n\
import Bagel"
	LAUNCH_BODY="Bagel.start()"    
elif [ "$BUNDLE_IDENTIFIER" == "com.gp.OCZ" ]; then
    IMPORTS="import Foundation"
	LAUNCH_BODY="// Not launching DevelopmentTools for prod env"    
else
	echo "Unrecognized BUNDLE_IDENTIFIER!"
	exit 1
fi

OUTPUT=$(printf "// This file was generated using nmake_development_tools.sh script inside pre-build action.\n\
// Please do not edit\n\n\
$IMPORTS\n\n\
class DevelopmentTools {\n\
    static func launch() {\n\
    	$LAUNCH_BODY\n\
    }\n\
}")
echo "$OUTPUT" > "$SRC_ROOT/OCZ/Configuration/DevelopmentTools.swift"
