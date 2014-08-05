
IPython configuration and profiles
##################################

Three configuration files that I symlink for each profile:

- ``ipython_config.py``
- ``ipython_notebook_config.py``
- ``ipython_qtconsole_config.py``

Read the `introduction to the IPython configuration
<http://ipython.org/ipython-doc/dev/config/intro.html>`_.

Profiles
========

For now, the different profiles are just a ``startup`` folder and some Python
modules to load some packages and define some functions for a specific profile.

Three different profiles:

- ``cw`` dedicated to the Python web framework CubicWeb_
- ``datasci`` dedicated to pandas_, numpy_, scipy_ and matplotlib_
- ``image`` dedicated to image processing with numpy_, scipy_ and skimage_

.. _CubicWeb: http://www.cubicweb.org/
.. _pandas: http://pandas.pydata.org/
.. _numpy: http://numpy.org/
.. _scipy: http://scipy.org/
.. _matplotlib: http://matplotlib.org/
.. _skimage: http://scikit-image.org/

Deploying/installing
====================

A file Python ``deploy_profile`` manages these differents profiles and the IPy
configuration. It can install, clean-up or list the different profiles.

About installing, I just create some dirs and symlink the ``startup`` content to
the right place.

* List all profiles (installed and uninstalled):

::

   ./deploy_profiles -l/--list

* Deploy a specific profile:

::

   ./deploy_profiles -i/--install profile_name

or ``-a/--all`` to deploy all profiles.

* Clean-up a specific profile:

::

   ./deploy_profiles -c/--clean profile_name

The IPython configuration and profile directory is ``~/.ipython`` by
default. You can retrieve it by:

.. code-block:: python

   from IPython.utils.path import get_ipython_dir
   IPYTHONDIR = get_ipython_dir()

It's possible to deploy/clean-up profiles with the ``deploy_profiles`` for a
specific IPython config dir. with:

::

   IPYTHONDIR=specific/ipydir deploy_profile --all

to copying all profiles in ``specific/ipydir``.
