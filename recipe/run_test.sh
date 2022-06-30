#!/bin/bash
echo "Beginning tests"
spdir=$(python -c 'import site;print(site.getsitepackages()[0])')
if ! ls -l $spdir/stanfit4anon_model*; then
	echo "- Model library not found in: $spdir"
	exit -1
fi
echo "- Patching PyStan to prevent model dumping"
sed -i.bak 's@sys.path.append@# @' $spdir/pystan/model.py
echo "- Attempting to load prepared model"
status=$(python -c 'from prophet.models import PyStanBackend; PyStanBackend()' 2>&1 | cat)
echo "$status" | sed 's@^@| @'
if echo "$status" | grep "WARNING:"; then
	echo "- Test FAILED."
	exit -1
else
	echo "- Test SUCCEEDED."
fi
