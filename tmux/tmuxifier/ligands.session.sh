# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
#session_root "~/Projects/default"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.

# set date for opening laravel log file
printf -v date '%(%Y-%m-%d)T' -1 

if initialize_session "ligands"; then
    window_root "~/Projects/CRIMS/PHP_update/docker-build"
    new_window "Docker-build"
    window_root "~/Projects/CRIMS/PHP_update/docker-build/docker-compose"
    new_window "ligands-compose"
    run_cmd "vi ligands-compose.yml"
    window_root "~/Projects/CRIMS/PHP_update/docker-build/logs/ligands"
    new_window "Log-ligands"
    run_cmd "tail -f laravel-${date}.log"
    window_root "~/Projects/CRIMS/PHP_update/docker-build/logs"
    new_window "Log-"
    window_root "~/Projects/CRIMS/PHP_update/api_volumes/ligands/ligands"
    new_window "NVIM LIGANDS"
    run_cmd "vi"
    window_root "~/Projects/CRIMS/PHP_update/api_volumes/ligands/ligands"
    new_window "BASH LIGANDS"
    window_root "~/Projects/CRIMS/PHP_update/api_volumes/ligands/ligands"
    new_window "DB LIGANDS"
    run_cmd "docker exec -it ligands-postgres psql -Ucrims liganddb"
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
