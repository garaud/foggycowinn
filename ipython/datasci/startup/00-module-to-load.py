
import os.path as osp
import sys
import string
from distutils.version import StrictVersion

from io import StringIO
from datetime import date, datetime, timedelta

from dateutil.parser import parse as parsedate
from dateutil.relativedelta import relativedelta

from babel.numbers import format_number

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from pandas import Timestamp, Timedelta
from pandas.tseries import offsets
pd.options.display.width = 180
pd.options.display.max_colwidth = 100
# Matploblib 1.4 can use ggplot theme. Use pandas default theme either.
if StrictVersion(plt.matplotlib.__version__) < StrictVersion('1.4'):
    pd.options.display.mpl_style = 'default'
else:
    plt.style.use('ggplot')
if sys.version_info[0] != 3:
    import statsmodels
import scipy.stats

import sklearn
import sklearn.datasets

import seaborn as sns
sns.set_context('talk')
