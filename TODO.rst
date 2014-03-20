
TODO File
=========

:author: Damien Garaud
:date: 2014-03-20

General
-------

* Add a License
* Write a THANKS file
* Write more contents in the README file about Emacs config and dotfiles

Dotfiles
--------

* Try to well display my ZSH prompt with URxvt (the clock is not displayed)
* Add an =i3= configuration.
* Add my IPython profile with numpy and pandas
* zsh prompt: display if the tracked (git or hg) files are currently modified in
  a repo.
* Use a Git sub-module of a fork from oh-my-zsh? Allow to clone it and configure
  it thanks to the =bootstrap.sh= script?
* Use Prezto instead of oh-my-zsh?

Emacs
-----

* Move the ``custom`` part in ``foggy_look`` to a dedicated ELisp file.
* Check if there are some function in ``*.el`` files that I can move into
  ``foggy_functions.el``
* Make the ``ido-goto-symbol`` function work (at work).
* Understand why packages are not installed in the ``elpa`` dir in my ``emacs`` dir.
* Improve the funtion ``ccppout`` at ``foggy_dev``:
  - use the word where the cursor is
  - genelarize the concept to print an arbiratry variable even in Python
  - use ``save-excursion`` to store the cursor position
  - bind the function (find a keybinding)
* Add some contents about Emacs server to the ``emacs/README.org`` file.
* Clean up 'emacs/foggy_dev.el': Python part and C++ part. Too many comments !
* Try to manage default size according to screen resolution
* Fix errors and deprecated stuff (emacs23 => emacs24)
* Make doc-mode work to edit/modify Doxygen comments (in C++ file)
* Configure Org-mode properly (agile, Getting Things Done, ...)
