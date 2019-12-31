#! /usr/bin/env bash

set -euo pipefail

# ignore linenumbers (for now)
export DEV_NO_LINENUMER=1

test_ok=0
test_cnt=0

for testfile in test/*.test.gd ; do
    let test_cnt+=1
    TESTNAME="$(basename $testfile .test.gd)"
    echo -n "$TESTNAME"
    RESULTFILE="test/$TESTNAME.result.gd"
    RESULT="$(./patch.pl $testfile)"
    if [[ ! -e $RESULTFILE ]]; then
        echo -n " - no result - create it"
        echo "$RESULT" > $RESULTFILE
    fi
    DIFF="$( diff -u $RESULTFILE <(echo "$RESULT") )"
    if [[ -z "$DIFF" ]]; then
        echo " - fine"
        let test_ok+=1
    else
        echo " - fail"
    fi
    # debug
    #rm -f $RESULTFILE
done

echo ""
echo "Result: $test_ok/$test_cnt fine"
