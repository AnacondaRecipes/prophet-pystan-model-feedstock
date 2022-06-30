import os
import site
import prophet
from prophet.models import PyStanBackend
p = PyStanBackend()
spath = site.getsitepackages()[0]
fname = os.path.join(os.path.join(spath, p.model.module_filename))
print('Writing:', fname)
with open(fname, 'wb') as fp:
    fp.write(p.model.module_bytes)
