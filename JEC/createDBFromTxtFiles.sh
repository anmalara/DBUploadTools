#! /bin/sh


ERA=$2
DIR=$1/$ERA

if [ $# -ne 2 ]; then
    echo "Usage: ./createDBFromTxtFiles.sh /nfs/dust/cms/user/amalara/WorkingArea/UHH2_106X_v2_UL/CMSSW_10_6_28/src/UHH2/JECDatabase/textFiles Winter23Prompt23_V1_MC"
    exit 1
fi

if [ ! -d "$DIR" ]; then
    echo "Error: $DIR does not exist"
    exit 1
fi

if [ -d "../data" ]; then
    echo "Error: 'data' folder already exist. Please remove it before launching this script"
    exit 1
fi

# Copy folder
cp -r "$DIR" ../data

# Delete symlinks
../removeSymlinks.sh ../data

# Create database
#LOG=`mktemp`
LOG=${ERA}.log
#cmsRun createDBFromTxtFiles.py era=$ERA path=JetMETCorrections/DBUploadTools/data/ 
cmsRun createDBFromTxtFiles.py era=$ERA path=JetMETCorrections/DBUploadTools/data/ &> "$LOG"

./parseLog.sh "$LOG"

if [ $? -eq 0 ]; then
    echo "Database successfully created as ${ERA}.db"
fi
