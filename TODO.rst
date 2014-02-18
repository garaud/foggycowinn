
TODO File
=========

:author: Damien Garaud
:date: 2011-08-23

General
-------

* Add a License
* Write a THANKS file

Dotfiles
--------

* Add an =i3= configuration.
* zsh prompt: display if the tracked (git or hg) files are currently modified in
  a repo.
* Use a Git sub-module of a fork from oh-my-zsh? Allow to clone it and configure
  it thanks to the =bootstrap.sh= script?
* Use Prezto instead of oh-my-zsh?

Emacs
-----

* Move the ``custom`` part in ``foggy_look`` to a dedicated ELisp file.
* Try to decrease the title size of Org-Mode for the theme tangotango
* Improve the funtion ``ccppout`` at ``foggy_dev``:
  - use the word where the cursor is
  - genelarize the concept to print an arbiratry variable even in Python
  - use ``save-excursion`` to store the cursor position
  - bind the function (find a keybinding)
* Add some contents about Emacs server to the ``emacs/README.org`` file.
* Clean up 'emacs/foggy_dev.el': Python part and C++ part. Too many comments !
* Try to manage default size according to screen resolution
* Fix errors and deprecated stuff (emacs23 => emacs24)
* Find a way to add some snippets (doxygen, python) to yasnippet
