# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
#session_root "~/Projects/default"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.

# set date for opening laravel log file
printf -v date '%(%Y-%m-%d)T' -1 

if initialize_session "datasets"; then
    window_root "~/Projects/CRIMS/PHP_update/docker-build"
    new_window "Docker-build"
    window_root "~/Projects/CRIMS/PHP_update/docker-build/docker-compose"
    new_window "datasets-compose"
    run_cmd "vi dataset_manager-compose.yml"
    window_root "~/Projects/CRIMS/PHP_update/docker-build/logs/dataset-manager"
    new_window "Log-datasets"
    window_root "~/Projects/CRIMS/PHP_update/docker-build/logs"
    run_cmd "tail -f laravel-${date}.log"
    new_window "Log-"
    window_root "~/Projects/CRIMS/PHP_update/api_volumes/dataset_manager/laravel"
    new_window "NVIM DATASETS"
    run_cmd "vi"
    window_root "~/Projects/CRIMS/PHP_update/api_volumes/dataset_manager/laravel"
    new_window "BASH DATASETS"
    window_root "~/Projects/CRIMS/PHP_update/api_volumes/dataset_manager/laravel"
    new_window "DB DATASETS"
    run_cmd "docker exec -it dataset_manager-postgres psql -Udata_manager crims_archive"
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
