# -*- coding: utf-8 -*-

def print_datasci_version():
    """Just print versions of current packages.
    """
    print('numpy version {}'.format(np.__version__))
    print('pandas version {}'.format(pd.__version__))

def _gen_random_dataframe(size=150, freq='B'):
    """Function which generates arbitrary dates & DataFrame with random
    variables.
    """
    dates = pd.date_range('2011-04-23', periods=size, freq=freq)
    X = np.cumsum(np.random.randn(size))
    Y = 2. + np.cumsum(np.random.randn(size)) * 0.75
    Z = np.random.randint(-3, 4, size)
    return pd.DataFrame({'X': X,
                         'Y': Y,
                         'Z': Z}, index=dates)

def _gen_random_array(size=(6, 4)):
    """Generate a random (normal) numpy array.
    """
    return np.random.randn(*size)

def _gen_str_series(rawtext=None):
    """Generate a Series of strs.

    rawtext: str
        suppose you split the str to pick each word.
    """
    if not rawtext:
        rawtext = "nerd casual jerk #game phone geek! 1337 glop"
    return pd.Series(rawtext.split())

def _gen_timeseries(dates=None):
    """Generate a Series with dates index.

    dates: DatetimeIndex
    """
    if dates is None:
        dates = pd.date_range('2013-07-17', periods=20, freq='D')
    return pd.Series(np.sin(0.2 * np.arange(dates.size)), index=dates)

def _gen_dataframe_types():
    """Generate a DataFrame with different dtypes.

    Usefull to show groupby, mask (isin), sort by str or int, etc.
    """
    return pd.DataFrame({'X': [1.2, -5.6, 4.7, 0.5, -2.3, 4.9],
                         'Q': ['d', 'g', 'e', 'z', 'k', 'a'],
                         'U': [3, 6, 2, 7, 2, 4],
                         'T': ['AA', 'FG', 'FG', 'AA', 'FG', 'KL']})

a = _gen_random_array()
s = _gen_str_series()
ts = _gen_timeseries()
df = _gen_random_dataframe()
dfm = _gen_dataframe_types()
print_datasci_version()
msg = """\nVariables:
- 'a': random array
- 's': Series of str
- 'ts': Series with dates
- 'df': DataFrame 3 columns of random float and int
- 'dfm': DataFrame 3 columns multiple data: float, int, str
"""
print(msg)
