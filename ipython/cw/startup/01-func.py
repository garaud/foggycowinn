# -*- coding: utf-8 -*-

# Wrap some useful CubicWeb functions to query the repo.

REPO = None

# Just do
# REPO = repo('instance_name')

def repo(appid):
    """Get a repo for a specific instance.

    appid: str
        name of the instance.
    """
    return repoapi._get_inmemory_repo(config=cwcfg.config_for(appid))


def rql(query, replacement=None):
    """Execute a query

    query: str
        RQL query
    replacement: tuple or dict
        Value to replace in query -- replace %s or %(key)s.

    Return a ResultSet
    """
    with REPO.internal_cnx() as cnx:
        return cnx.execute(query, replacement)
