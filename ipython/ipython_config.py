
import builtins
from IPython.lib import deepreload

# https://ipython.readthedocs.io/en/stable/api/generated/IPython.lib.deepreload.html

# Configuration file for ipython.
c = get_config()

# Set the color scheme (NoColor, Linux, or LightBG).
#c.TerminalInteractiveShell.colors = 'LightBG'

# Enable deep (recursive) reloading by default. IPython can use the deep_reload
# module which reloads changes in modules recursively (it replaces the reload()
# function, so you don't need to change anything to use it). deep_reload()
# forces a full reload of modules whose code may have changed, which the default
# reload() function does not.  When deep_reload is off, IPython will use the
# normal reload(), but deep_reload will still be available as dreload().
builtins.reload = deepreload.reload

# add the autorelaod extenstion by defaut.
c.InteractiveShellApp.exec_lines = []
c.InteractiveShellApp.exec_lines.append('%load_ext autoreload')
c.InteractiveShellApp.exec_lines.append('%autoreload 2')

# Set to confirm when you try to exit IPython with an EOF (Control-D in Unix,
# Control-Z/Enter in Windows). By typing 'exit' or 'quit', you can force a
# direct exit without any confirmation.
c.TerminalInteractiveShell.confirm_exit = False

# Configure matplotlib for interactive use with the default matplotlib backend.
# c.InteractiveShellApp.matplotlib = 'auto'
