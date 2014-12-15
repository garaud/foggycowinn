# Configuration file for ipython-qtconsole.

c = get_config()

# Start the console window maximized.
c.IPythonQtConsoleApp.maximize = True

# Set to display confirmation dialog on exit. You can always use 'exit' or
# 'quit', to force a direct exit without any confirmation.
c.IPythonQtConsoleApp.confirm_exit = False

# The font size. If unconfigured, Qt will be entrusted with the size of the
# font.
c.IPythonWidget.font_size = 11
