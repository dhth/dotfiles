#!/usr/bin/env bash

open_encoded_url() {
    # Check if an argument is provided
    if [ $# -eq 0 ]; then
        echo "Usage: open_encoded_url <URL>"
        return 1
    fi

    # Encode the URL using Python
    encoded_url=$(python -c "import urllib.parse; print(urllib.parse.quote('$1'))")

    # Open the encoded URL in the default web browser
    open "$encoded_url"
}
