# -*- coding: utf-8 -*-

# (name, module obj)
_PKG_LIST = (('scipy', scipy), ('numpy', np), ('pandas', pd),
             ('matplotlib', plt.matplotlib), ('sklearn', sklearn))

DATASCI_HELP_MSG = """\nVariables:
- 'a': normal random array
- 's': Series of str
- 'ts': Series with dates
- 'df': DataFrame 3 columns of random float and int
- 'dfl': DataFrame to test the 'join' feature with 'dfr'
- 'dfr': see 'dfl'
- 'dfna': DataFrame 3 columns and some missing values
- 'dfm': DataFrame 3 columns multiple data: float, int, str
- 'dfmidx': DataFrame with 2 cols and a MultiIndex
"""


def print_datasci_version():
    """Just print versions of some loaded packages.
    """
    msg = "  - {0} version {1}"
    for name, module in _PKG_LIST:
        print(msg.format(name, module.__version__))

def datasci_help(msg=DATASCI_HELP_MSG):
    print(msg)

def _gen_random_dataframe(size=150, freq='B'):
    """Function which generates arbitrary dates & DataFrame with random
    variables.
    """
    dates = pd.date_range('2011-04-23', periods=size, freq=freq)
    dates.name = "date"
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
    dates.name = "date"
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
    index = pd.MultiIndex.from_tuples(list(zip(*idx_level)))
    return pd.DataFrame(np.random.randn(6, 2), index=index, columns=['X','Y'])


def _lineno(fpath):
    """Count the number of lines in a file

    Inspired from http://stackoverflow.com/questions/845058/how-to-get-line-count-cheaply-in-python
    """
    import mmap
    with open(fpath, "r+") as fobj:
        buf = mmap.mmap(fobj.fileno(), 0)
        lines = 0
        while buf.readline():
            lines += 1
        return lines-1


def read_head(fpath, head=5):
    """Read the head of a CSV file

    fpath: str
    head: int (default 5)

    Return a DataFrame
    """
    with open(fpath, 'r') as fobj:
        reader = pd.read_csv(fobj, chunksize=head)
    return reader.get_chunk()


def random_read(fpath, chunksize, **kwargs):
    """Randomly read a CSV file with a specific chunksize

    fpath: str
    chunksize: int
    kwargs: passing args to `pd.read_csv`

    Return a DataFrame with ~`chunksize` lines
    """
    df = pd.DataFrame()
    split = 20
    chunk = lineno(fpath) // split
    take = chunksize // split
    with open(fpath, "r", encoding='utf-8') as fobj:
        reader = pd.read_csv(fpath, encoding='utf-8', chunksize=chunk, **kwargs)
        for group in iter(reader):
            df = df.append(group.sample(take))
    return df.sort_index()


def prtfloat(number):
    """Just pretty print float with a thousand separator
    """
    print(format_number(number, 'en_US'))


a = _gen_random_array()
s = _gen_str_series()
ts = _gen_timeseries()
df = _gen_random_dataframe()
dfna = _gen_random_dataframe(size=50, freq='D')
dfna['X'].iloc[[0,3,5,12,22,36]] = np.nan
dfna['Y'].iloc[[3,7,15,25,26,42]] = np.nan
dfl = pd.DataFrame({"name": ["davis", "coltrane", "hankock", "hendrix", "barber"],
                    "x": [52., 32., 45., 56., 18.]})
dfr = pd.DataFrame({"y": [23., 47., 18., 36.]},
                   index=["coltrane", "hendrix", "brubeck", "davis"])
dfm = _gen_dataframe_types()
dfmidx = _gen_multiindex_dataframe()
print_datasci_version()
datasci_help()
