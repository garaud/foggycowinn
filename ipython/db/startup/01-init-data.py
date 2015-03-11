# -*- coding: utf-8 -*-

from sqlalchemy import Table, Column, Integer, String, MetaData

# Suppose the '00-module-to_load' Python file was loaded.
IPYTEST_DB_FILE = "/tmp/ipytest.db"


def _create_dbfile(filepath=IPYTEST_DB_FILE):
    """Create a temporary db file (SQLite). Replace it if exist.
    """
    if os.path.isfile(filepath):
        os.remove(filepath)
    return create_engine("sqlite:///{}".format(filepath))

def _create_table(engine):
    """Create the 'jazz' table
    """
    metadata = MetaData()
    jazz = Table('jazz', metadata,
                 Column("id", Integer, primary_key=True, autoincrement=True),
                 Column("name", String(80)),
                 Column("birth", Integer),
                 Column("play", String(80)))
    metadata.create_all(engine)
    return jazz

def _populate_table(engine, table):
    with engine.connect() as cnx:
        cnx.execute(table.insert(), [
                        {"name": "John Coltrane", "birth": 1926, "play": "Saxo"},
                        {"name": "Miles Davis", "birth": 1926, "play": "Trumpet"},
                        {"name": "Herbie Hancock", "birth": 1940, "play": "Piano"},
                        {"name": "Patricia Barber", "birth": 1955, "play": "Piano/Voice"}]
                )

def read_sqlite(filepath):
    """Read the SQLite filename.
    Return a db.py object.
    """
    return DB(filename=filepath, dbtype="sqlite")


# In-memory SQLite db
engine = _create_dbfile()
jazz = _create_table(engine)
_populate_table(engine, jazz)

# Put a DataFrame table named 'df'
df = pd.DataFrame.from_items([("date", pd.date_range("2015-03-22", periods=20, freq='B')),
                              ("X", np.random.random(20)),
                              ("Y", np.random.random_integers(-2, 2, 20))])
df.to_sql("df", engine, if_exists='replace')

# db.py
db = DB(filename=IPYTEST_DB_FILE, dbtype='sqlite')
