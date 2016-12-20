from notebook.auth import passwd
import os
# Configuration file for jupyter-notebook.

#------------------------------------------------------------------------------
# Configurable configuration
#------------------------------------------------------------------------------

# The IP address the notebook server will listen on.
c.NotebookApp.ip = '*'


# The port the notebook server will listen on.
c.NotebookApp.port = int(os.getenv('PORT', 8888))


# Whether to open in a browser after starting. The specific browser used is
# platform dependent and determined by the python standard library `webbrowser`
# module, unless it is overridden using the --browser (NotebookApp.browser)
# configuration option.
c.NotebookApp.open_browser = False

# Hashed password to use for web authentication.
#
# To generate, type in a python/IPython shell:
#
#   from notebook.auth import passwd; passwd()
#
# The string should be of the form type:salt:hashed-password.
if 'PASSWORD' in os.environ:
  c.NotebookApp.password = passwd(os.environ['PASSWORD'])
  del os.environ['PASSWORD']
else:
  # Default Password (JUPYTER_PASS)
  c.NotebookApp.password = u'sha1:7e0ab7caf27c:422094f7d4d0db54819a305e20cffbebe199daed'
