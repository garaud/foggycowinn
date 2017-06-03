
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

Emacs
-----

* Check if there are some function in ``*.el`` files that I can move into
  ``foggy_functions.el``
* Improve the funtion ``ccppout`` at ``foggy_dev``:
  - use the word where the cursor is
  - genelarize the concept to print an arbiratry variable even in Python
  - use ``save-excursion`` to store the cursor position
  - bind the function (find a keybinding)
* Try to manage default size according to screen resolution
  - try it with ``(x-display-pixel-height)`` and ``(x-display-pixel-width)``
* Try to highlight symbols during smartscan
  https://github.com/mickeynp/smart-scan
  - M-n, M-p next/previous symbols
* Make doc-mode work to edit/modify Doxygen comments (in C++ file)
* Configure Org-mode properly (agile, Getting Things Done, ...)
