# -*- coding: utf-8 -*-

import os.path as osp
from StringIO import StringIO
from pprint import pprint
from datetime import datetime, date, time

import cubicweb as cw
from cubicweb import repoapi
from cubicweb.cwconfig import CubicWebConfiguration as cwcfg

print("\n* CubicWeb version {}".format(cw.__version__))
