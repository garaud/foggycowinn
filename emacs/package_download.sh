#!/bin/bash
# Author: Damien Garaud
# A basic Bash script to copy/clone Emacs packages into a directory. The name
# and URL of each Emacs package are specified in the text file 'package_list'.

# Path where you would like to copy/clone some Emacs packages.
# It can be '$HOME/.emacs.d/' for instance.
package_dir=$HOME/applications/emacs

if [ ! -d $package_dir ]; then
    echo "'$package_dir' does not exist."
    echo "Please set the 'package_dir' variable in this file."
    exit 0
else
    package_dir=$HOME/.emacs.d
fi

# Go to the dir where different emacs packages will be.
pushd $package_dir

# XXX This path must be the same as the path specified in your '.emacs' with the
# variable 'emacs-foggy-package-dir'. It you don't have this variable, please
# add it.
# (setq emacs-foggy-package-dir "~/applications/emacs")


# Package name specified in the text file 'package_list' (with Git URL).
package_list_name=`awk '{print $1}' package_list`

# Loop on package list.
echo "Check packages..."
for name in $package_list_name; do
    # Check if the package has already cloned.
    if [ -d $package_dir"/"$name ]; then
        echo "'$name' already exist."
    else
	url=`grep $name package_list | awk '{print $2}'`
	# XXX Handle the Mercurial case.
	echo $url
        if [[ "$url" == *git* ]]; then
	    git clone $url
	else
	    wget $url
	fi
    fi
done

# Go back to the foggycowin dir.
popd
