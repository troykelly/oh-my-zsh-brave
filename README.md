# Oh My Zsh Plugin - Brave Browser Profiles

This plugin for Oh My Zsh makes it easier to manage your Brave Browser profiles. With this plugin, you can start Brave Browser with a specific user profile by using the `brave` command followed by the profile's name. The plugin also implements autocompletion for the profile names so you won't have to type the entire profile name manually.

## Installation

There are two ways to install this plugin:

### 1. Automatic installation:

Add this snippet to your `.zshrc` file:

```zsh
# Check for the brave-profiles plugin and install if it doesn't exist
if [ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/braveprofiles" ]; then
    git clone --depth=1 https://github.com/troykelly/oh-my-zsh-brave ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/braveprofiles
fi
```

Then, source your `.zshrc`:

```zsh
source ${HOME}/.zshrc
```

### 2. Manual installation:

First, clone this repository into `$ZSH_CUSTOM/plugins` (by default this is `${HOME}/.oh-my-zsh/custom/plugins`):

```zsh
git clone --depth=1 https://github.com/troykelly/oh-my-zsh-brave ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/braveprofiles
```

### 3. Enable plugin:

Next, add the `braveprofiles` plugin to your `.zshrc` file plugins list. Here's an example:

```zsh
plugins=(… braveprofiles)
```

Finally, source your `.zshrc` to apply the changes:

```zsh
source ${HOME}/.zshrc
```

## Usage

To start Brave Browser with a specific profile, simply type `brave` followed by the profile's name:

```zsh
brave profile-name
```

As soon as you start typing the `brave` command and then press the space and Tab keys, Oh My Zsh will suggest available profile names. Continue typing the intended profile name, and the shell will continue to suggest matching profiles.

## Updating

To manually update the plugin, go to its directory (`${HOME}/.oh-my-zsh/custom/plugins/braveprofiles` by default), and run `git pull`.

To set up automatic updates whenever you start a new shell session, add these lines to your `.zshrc`:

```zsh
update_custom_plugins() {
  # Check the zstyle value for auto-update
  local mode
  zstyle -g mode ':omz:update' mode 

  # If the mode is not 'auto', exit
  if [[ "$mode" != 'auto' ]]; then
    return
  fi

  local plugins_path="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins"
  local plugin
  
  for plugin in "$plugins_path"/*; do
    if [ -d "$plugin/.git" ]; then
      # Quietly attempt to update the plugin
      local git_output
      git_output=$(git -C "$plugin" pull 2>/dev/null)
      
      # If the output does not include the "Already up to date." string,
      # then an update was performed.
      if [[ "$git_output" != *"Already up to date."* ]]; then
        echo "Updated ${plugin##*/}!"
      fi
    fi
  done
}

# Run the updates
update_custom_plugins
```

After saving these changes to `.zshrc`, the plugin will automatically make sure it's updated to the latest version whenever you open a new shell session.