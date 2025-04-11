# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
#session_root "~/Projects/default"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.

# set date for opening laravel log file
printf -v date '%(%Y-%m-%d)T' -1 

if initialize_session "plates"; then
    window_root "~/Projects/CRIMS/PHP_update/docker-build"
    new_window "Docker-build"
    window_root "~/Projects/CRIMS/PHP_update/docker-build/docker-compose"
    new_window "plates-compose"
    run_cmd "vi plates-compose.yml"
    window_root "~/Projects/CRIMS/PHP_update/docker-build/logs/plates"
    new_window "Log-plates"
    run_cmd "tail -f laravel-${date}.log"
    window_root "~/Projects/CRIMS/PHP_update/docker-build/logs"
    new_window "Log-"
    window_root "/home/crims/Projects/CRIMS/PHP_update/api_volumes/plates/laravel"
    new_window "NVIM PLATES"
    run_cmd "vi"
    window_root "/home/crims/Projects/CRIMS/PHP_update/api_volumes/plates/laravel"
    new_window "BASH PLATES"
    window_root "/home/crims/Projects/CRIMS/PHP_update/api_volumes/plates/laravel"
    new_window "DB PLATES"
    run_cmd "docker exec -it plates-postgres psql -Ucrims-plates agility"
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
