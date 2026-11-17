#!/bin/bash

SUDO=$(which sudo 2> /dev/null)

USE_BASH=false
SYMLINK_ARGS=()
POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
	case "$1" in
		--debug)
			set -xv
			SYMLINK_ARGS+=("$1")
			shift
			;;
		--no-backup)
			SYMLINK_ARGS+=("$1")
			shift
			;;
		--bash)
			USE_BASH=true
			shift;;
		*)
			POSITIONAL_ARGS+=("$1")
			shift
			;;
	esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

# Check if echoc is available; we use it here
if ! command -v echoc &> /dev/null; then
	SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
	export PATH="$(realpath -sm "${SCRIPT_DIR}/.bash-lib"):$PATH"
fi
command -v echoc &> /dev/null || { echo "Could not find command: echoc"; exit 1; }
command -v safe_create_symlink &> /dev/null || { echo "Could not find command: safe_create_symlink"; exit 1; }

# Check if awk has been updated
# check_tool_deps "${CHECK_ARGS[@]}" gawk:awk && exit 1

# Other
echoc -header "Setting up miscellaneous items"

echoc -subheader "Creating symlinks"
safe_create_symlink . "${HOME}/.dotfiles" "${SYMLINK_ARGS[@]}"
safe_create_symlink zshrc "${HOME}/.zshrc" "${SYMLINK_ARGS[@]}"
safe_create_symlink bashrc "${HOME}/.bashrc" "${SYMLINK_ARGS[@]}"
safe_create_symlink gitconfig "${HOME}/.gitconfig" "${SYMLINK_ARGS[@]}"
safe_create_symlink psqlrc "${HOME}/.psqlrc" "${SYMLINK_ARGS[@]}"
safe_create_symlink dust.toml "${HOME}/.dust.toml" "${SYMLINK_ARGS[@]}"

echo "export PATH=\${PATH}:~/.dotfiles/bin" >> ~/.profile


echoc -subheader "Configuring default shell"
if $USE_BASH; then
	echo "Setting bash as default shell"
	[ -f /etc/ptmp ] && $SUDO rm -f /etc/ptmp
	if [[ "$SHELL" != "$(which bash)" ]]; then
		$SUDO chsh -s "$(which bash)" "${USER}"
	fi

	echo '
# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi
' >> "${HOME}/.bash_profile"
else
	echo "Setting zsh as default shell"
	[ -f /etc/ptmp ] && $SUDO rm -f /etc/ptmp
	if [[ "$SHELL" != "$(which zsh)" ]]; then
		$SUDO chsh -s "$(which zsh)" "${USER}"
	fi
fi


echoc -header "Downloading antigen modules"
zsh -c "source ~/.zshrc"
