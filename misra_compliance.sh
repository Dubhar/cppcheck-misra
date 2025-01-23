#!/usr/bin/env ash

echo "## Creating CPPCHECK dump ##"
"${CPPCHECK_INSTALL}"/bin/cppcheck --dump --quiet /src

echo "## Checking dump for MISRA compliance ##"
RULES_PATH="${RULES_PATH:-${CPPCHECK_REPO}/addons/test/misra/misra_rules_dummy.txt}"
python "${CPPCHECK_REPO}/addons/misra.py" --rule-texts="${RULES_PATH}" /src/*.dump
