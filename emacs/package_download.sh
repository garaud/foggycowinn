#!/bin/sh
# Damien Garaud
# A basic Shell script to copy/clone Emacs packages into a directory. The name
# and Git URL of each Emacs package are specified in the text file
# 'package_list'.

# Path where you would like to copy/clone some Emacs packages.
# It can be '$HOME/.emacs.d/' for instance.
package_dir=$HOME/applications/emacs

# XXX This path must be the same as the path specified in your '.emacs' with the
# variable 'emacs-foggy-package-dir'. It you don't have this variable, please add it.
# (setq emacs-foggy-package-dir "~/applications/emacs")


# Package name specified in the text file 'package_list' (with Git URL).
package_list_name=`awk '{print $1}' package_list`

# Function which copy/clone a list of Emacs packages.
function clone
{
    echo "Ckeck packages..."
    for name in $package_list_name; do
        # Check if the package has already cloned.
        if [ -d $package_dir"/"$name ]; then
            echo "'$name' already exist."
        else
            here=`pwd`
            url=`grep $name package_list | awk '{print $2}'`
            cd $package_dir
            git clone $url
            cd $here
        fi
    done
}


echo "Check '$package_dir'"
if [ -d $package_dir ]; then
    clone
else
    echo "Create '$package_dir'"
    mkdir $package_dir
    clone
fi
