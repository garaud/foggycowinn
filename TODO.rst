
TODO File
=========

:author: Damien Garaud
:date: 2014-03-20

General
-------

* Add a License
* Write a THANKS file

Dotfiles
--------

* Clone and deploy/install dependencies when I need to install my config on a
  new environment (prezto, fasd, zshmarks, etc.)
* Try to well display my ZSH prompt with URxvt (the clock is not displayed)
* Add an =i3= configuration.
* zsh prompt: display if the tracked (git or hg) files are currently modified in
  a repo.
* Use a Git sub-module of a fork from oh-my-zsh? Allow to clone it and configure
  it thanks to the =bootstrap.sh= script?
* Use Prezto instead of oh-my-zsh?

Emacs
-----

* Check if there are some function in ``*.el`` files that I can move into
  ``foggy_functions.el``
* Try to refactor the 'highlight XXX and TODO words' in the file ``foggy_look.el``
* Understand why packages are not installed in the ``elpa`` dir in my ``emacs``
  dir.
* Improve the funtion ``ccppout`` at ``foggy_dev``:
  - use the word where the cursor is
  - genelarize the concept to print an arbiratry variable even in Python
  - use ``save-excursion`` to store the cursor position
  - bind the function (find a keybinding)
* Add some contents about Emacs server to the ``emacs/README.org`` file.
* Try to manage default size according to screen resolution
  - try it with ``(x-display-pixel-height)`` and ``(x-display-pixel-width)``
* Make doc-mode work to edit/modify Doxygen comments (in C++ file)
* Configure Org-mode properly (agile, Getting Things Done, ...)
