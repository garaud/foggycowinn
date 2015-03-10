# -*- coding: utf-8 -*-


# Suppose the '00-module-to_load' Python file was loaded.
IPYTEST_DB_FILE = "/tmp/ipytest.db"

def _create_dbfile(filepath=IPYTEST_DB_FILE):
    """Create a temporary db file (SQLite). Replace it if exist.
    """
    if os.path.isfile(filepath):
        os.remove(filepath)
    return create_engine("sqlite:///{}".format(filepath))

def _create_table(engine):
    engine.execute("CREATE TABLE jazz (name,birth,play)")

def _populate_table(engine):
    engine.execute("""INSERT INTO jazz values
    ('John Coltrane', 1926, 'Saxo')""")
    engine.execute("""INSERT INTO jazz values
    ('Miles Davis', 1926, 'Trumpet')""")
    engine.execute("""INSERT INTO jazz values
    ('Herbie Hancock', 1940, 'Piano')""")
    engine.execute("""INSERT INTO jazz values
    ('Patricia Barber', 1955, 'Piano/Voice')""")


# In-memory SQLite db
engine = _create_dbfile()
_create_table(engine)
_populate_table(engine)

# Put a DataFrame table named 'df'
df = pd.DataFrame({"date": pd.date_range("2015-03-22", periods=20, freq='B'),
                   "X": np.random.random(20),
                   "Y": np.random.random_integers(-2, 2, 20)})
df.to_sql("df", engine, if_exists='replace')

# db.py
db = DB(filename=IPYTEST_DB_FILE, dbtype='sqlite')
