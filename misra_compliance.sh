#!/usr/bin/env ash

echo "Creating CPPCHECK dump"
cppcheck --dump --quiet /src

echo "Checking dump for"
python "${CPPCHECK_PATH}/addons/misra.py" --rule-texts="${CPPCHECK_PATH}/addons/test/misra/misra_rules_dummy.txt" /src/*.dump
