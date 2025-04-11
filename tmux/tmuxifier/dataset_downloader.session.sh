# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
#session_root "~/Projects/default"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.

# set date for opening laravel log file
printf -v date '%(%Y-%m-%d)T' -1 

if initialize_session "dataset_downloader"; then
    window_root "~/Projects/CRIMS/PHP_update/docker-build"
    new_window "Docker-build"
    window_root "~/Projects/CRIMS/PHP_update/docker-build/docker-compose"
    new_window "dataset_downloader-compose"
    run_cmd "vi dataset_downloader-compose.yml"
    window_root "~/Projects/CRIMS/PHP_update/docker-build/logs/dataset-downloader"
    new_window "Log-dataset_downloader"
    run_cmd "tail -f laravel-${date}.log"
    window_root "~/Projects/CRIMS/PHP_update/docker-build/logs"
    new_window "Log-"
    window_root "~/Projects/CRIMS/PHP_update/api_volumes/dataset_downloader/dataset_downloader/laravel"
    new_window "NVIM DATASET_DOWNLOADER"
    run_cmd "vi"
    window_root "~/Projects/CRIMS/PHP_update/api_volumes/dataset_downloader/dataset_downloader/laravel"
    new_window "BASH DATASET_DOWNLOADER"
    window_root "~/Projects/CRIMS/PHP_update/api_volumes/dataset_downloader/dataset_downloader/laravel"
    new_window "DB DATASET_DOWNLOADER"
    run_cmd "docker exec -it dataset_downloader-postgres psql -Udataset_downloader crims_archive"
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
