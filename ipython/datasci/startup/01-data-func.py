# -*- coding: utf-8 -*-

# (name, module obj)
_PKG_LIST = (('scipy', scipy), ('numpy', np), ('pandas', pd))

def print_datasci_version():
    """Just print versions of some loaded packages.
    """
    msg = "  - {0} version {1}"
    for name, module in _PKG_LIST:
        print(msg.format(name, module.__version__))

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

def _gen_str_series(rawtext=None, sep=None):
    """Generate a Series of strs.

    rawtext: str
        suppose you split the str to pick each word.
    sep: str, None
        Can pass a specific separator to 'split()'

    ::

       _gen_str_series('John Coltrane,Miles Davis', sep=',')

    if you don't want to split with whitespaces.
    """
    if not rawtext:
        rawtext = "nerd casual jerk #game phone geek! 1337 glop"
    return pd.Series(rawtext.split(sep))

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
    return pd.DataFrame({'X': [1.2, -5.6, 4.7, 0.5, -2.3, 4.9, -2., 5.4, 12.3],
                         'Q': ['d', 'g', 'e', 'z', 'k', 'a', 'x', 'r', 't'],
                         'U': [3, 6, 2, 7, 2, 4, 3, 7, 2],
                         'T': ['AA', 'FG', 'FG', 'AA', 'FG', 'KL', 'KL', 'AA', 'MV']})

def _gen_multiindex_dataframe():
    """Generate a DataFrame with 2 cols and a MultiIndex.
    """
    idx_level = (['A', 'A', 'A', 'C', 'C', 'C'],
                 [1, 2, 3, 1, 2, 3])
    index = pd.MultiIndex.from_tuples(zip(*idx_level))
    return pd.DataFrame(np.random.randn(6, 2), index=index, columns=['X','Y'])


def _gen_panel():
    """Generate a simple Panel with three keys.
    """
    df_index_size = 25
    return pd.Panel({'cat_S': _gen_random_dataframe(df_index_size, freq='D'),
                     'cat_T': _gen_random_dataframe(df_index_size, freq='B'),
                     'cat_U': _gen_random_dataframe(df_index_size, freq='D')})

a = _gen_random_array()
s = _gen_str_series()
ts = _gen_timeseries()
df = _gen_random_dataframe()
dfm = _gen_dataframe_types()
dfmidx = _gen_multiindex_dataframe()
panel = _gen_panel()
print_datasci_version()
msg = """\nVariables:
- 'a': normal random array
- 's': Series of str
- 'ts': Series with dates
- 'df': DataFrame 3 columns of random float and int
- 'dfm': DataFrame 3 columns multiple data: float, int, str
- 'dfmidx': DataFrame with 2 cols and a MultiIndex
- 'panel': Panel with three random DataFrame (3 columns)
"""
print(msg)
