#!/bin/bash

# Script for combining era-wise (or IOV-wise) database files to one db-file
# Usage: sh MergeBlaaBlaaDataDB.sh <JEC version number>

# 2017 absolute run periods:
# B:297020:299329
# C:299337:302029
# D:302030:303434
# E:303435:304826
# F:304911:306462
# Source: https://twiki.cern.ch/twiki/bin/viewauth/CMS/PdmV2017Analysis#Data

Version=$1

Output=Summer19UL17_RunBCDEF_V${Version}_DATA.db
rm -f $Output

#for Algo in AK4PF AK4PFchs AK4PFPuppi AK4JPT AK4Calo AK8PF AK8PFchs AK8PFPuppi
for Algo in AK4PFchs AK4PFPuppi
do
   for Period in B:297020:299329 C:299337:302029 D:302030:303434 E:303435:304826 F:304911:306462
   do
      Run=`echo $Period | cut --delim=':' --field=1`
      Start=`echo $Period | cut --delim=':' --field=2`
      End=`echo $Period | cut --delim=':' --field=3`
      Input=Summer19UL17_Run${Run}_V${Version}_DATA.db

      conddb_import -f sqlite_file:${Input} -c sqlite_file:${Output} \
         -i JetCorrectorParametersCollection_Summer19UL17_Run${Run}_V${Version}_DATA_${Algo} \
         -t JetCorrectorParametersCollection_Summer19UL17_RunABCD_V${Version}_DATA_${Algo} \
         -b $Start -e $End
   done
done
