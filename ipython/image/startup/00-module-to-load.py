# -*- coding: utf-8 -*-

from __future__ import print_function

import os.path as osp

from StringIO import StringIO

import numpy as np
import scipy.ndimage as nd
import scipy.misc as sc
import matplotlib.pyplot as plt
try:
    import skimage
except ImportError:
    print("Unable to load 'skimage'.")
    pass
