# Brave Browser Profiles Plugin

# Starts Brave Browser with the given profile
brave() {
    # The name of the profile is the first argument
    local profile_name="$1"

    # Check if a profile name was provided
    if [[ -z "$profile_name" ]]; then
        echo "Profile name not provided. Usage: brave <profile>"
        return 1
    fi

    # Define the directory for the specified profile
    local profile_dir=~/Brave/${profile_name}

    # Create the directory if it doesn't exist
    [[ ! -d "$profile_dir" ]] && mkdir -p "$profile_dir"

    # Start Brave Browser with the new user profile
    open -na "Brave Browser" --args "--user-data-dir=$profile_dir"
}

# Autocomplete function for Brave Browser Profiles
_brave() {
    # Retrieve list of existing profiles
    local -a profiles
    profiles=("${(@f)$(basename -a ~/Brave/*(/))}")

    # Provide list of profiles for autocompletion
    _describe 'brave profiles' profiles
}

# Attach the autocomplete function to the profile function
compdef _brave brave
