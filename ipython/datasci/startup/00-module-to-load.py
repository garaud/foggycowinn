# -*- coding: utf-8 -*-

from __future__ import print_function

import os.path as osp
import string

from StringIO import StringIO
from datetime import datetime, timedelta

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
pd.options.display.mpl_style = 'default'
try:
    import scikits.statsmodels as statsmodels
except ImportError:
    import statsmodels
import scipy.stats
