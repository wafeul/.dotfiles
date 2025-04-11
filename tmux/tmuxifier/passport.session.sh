# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
#session_root "~/Projects/default"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.

# set date for opening laravel log file
printf -v date '%(%Y-%m-%d)T' -1 

if initialize_session "passport"; then
    window_root "~/Projects/CRIMS/PHP_update/docker-build"
    new_window "Docker-build"
    window_root "~/Projects/CRIMS/PHP_update/docker-build/docker-compose"
    new_window "passport-compose"
    run_cmd "vi passport-compose.yml"
    window_root "~/Projects/CRIMS/PHP_update/docker-build/logs/passport"
    new_window "Log-passport"
    run_cmd "tail -f laravel-${date}.log"
    window_root "~/Projects/CRIMS/PHP_update/docker-build/logs"
    new_window "Log-"
    window_root "~/Projects/CRIMS/PHP_update/api_volumes/passport/passport/laravel"
    new_window "NVIM PASSPORT"
    run_cmd "vi"
    window_root "~/Projects/CRIMS/PHP_update/api_volumes/passport/passport/laravel"
    new_window "BASH PASSPORT"
    window_root "~/Projects/CRIMS/PHP_update/api_volumes/passport/passport/laravel"
    new_window "DB PASSPORT"
    run_cmd "docker exec -it passport-postgres psql -Ucrims-passport passport"
    select_window 5

    # Create a new window inline within session layout definition.
    #new_window "misc"

    # Load a defined window layout.
    #load_window "example"

    # Select the default active window on session creation.
    #select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
