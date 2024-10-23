# Brave Browser Profiles Plugin

# Function to start Brave Browser with the specified profile
brave() {
    # The name of the profile is the first argument
    local profile_name="$1"

    # Check if a profile name was provided
    if [[ -z "$profile_name" ]]; then
        echo "Error: Profile name not provided."
        echo "Usage: brave <profile_name>"
        return 1
    fi

    # Sanitize the profile name to remove any problematic characters
    profile_name="${profile_name//[^a-zA-Z0-9 _-]/}"
    profile_name="${profile_name## }"
    profile_name="${profile_name%% }"

    # Define the directory for the specified profile
    local profile_dir="$HOME/Brave/$profile_name"

    # Create the directory if it doesn't exist
    if [[ ! -d "$profile_dir" ]]; then
        if ! mkdir -p "$profile_dir"; then
            echo "Error: Failed to create profile directory: $profile_dir"
            return 1
        fi
    fi

    # Start Brave Browser with the new user profile
    if ! open -na "Brave Browser" --args \
        --user-data-dir="$profile_dir" \
        --enable-profile-shortcut-manager; then
        echo "Error: Failed to launch Brave Browser with profile: $profile_name"
        return 1
    fi
}

# Autocomplete function for Brave Browser profiles
_brave() {
    # Define the profiles directory
    local profiles_dir="$HOME/Brave"

    # Check if the profiles directory exists
    if [[ ! -d "$profiles_dir" ]]; then
        return 0 # No profiles to autocomplete
    fi

    # Retrieve list of existing profiles (directories within $profiles_dir)
    local -a profiles
    profiles=()

    # Use a loop to safely handle directory names with spaces
    local dir
    for dir in "$profiles_dir"/*; do
        [[ -d "$dir" ]] && profiles+=("${dir:t}")
    done

    # Provide list of profiles for autocompletion
    _describe 'brave profiles' profiles
}

# Attach the autocomplete function to the brave function
compdef _brave brave
