open -n -a "Google Chrome" --args \
    --profile-directory="$WORK_CHROME_PROFILE_NAME" $(cat $HOME/.WORK_STARTUP_URLS | xargs)
