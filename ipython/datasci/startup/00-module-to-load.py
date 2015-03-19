# -*- coding: utf-8 -*-

from __future__ import print_function

import os.path as osp
import string
from distutils.version import StrictVersion

from StringIO import StringIO
from datetime import date, datetime, timedelta

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from pandas.tseries import offsets
# Matploblib 1.4 can use ggplot theme. Use pandas default theme either.
if StrictVersion(plt.matplotlib.__version__) < StrictVersion('1.4'):
    pd.options.display.mpl_style = 'default'
else:
    plt.style.use('ggplot')
try:
    from pandas.rpy.common import load_data as load_R_dataset
except ImportError:
    pass
try:
    import scikits.statsmodels as statsmodels
except ImportError:
    import statsmodels
import scipy.stats
