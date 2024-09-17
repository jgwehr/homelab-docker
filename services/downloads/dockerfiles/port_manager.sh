#!/bin/bash

COOKIES="tmpcookies.txt"
PORT_CURRENT=""
PATTERN="[0-9]{5}" #ProtonVPN always produces a 5 digit port number

QBITTORRENT_URL_LOGIN="${QBITTORRENT_SECURE}://${QBITTORRENT_SERVER}:${QBITTORRENT_PORT}/api/v2/auth/login"
QBITTORRENT_URL_SETPREF="${QBITTORRENT_SECURE}://${QBITTORRENT_SERVER}:${QBITTORRENT_PORT}"
GLUETUN_URL="${GLUETUN_SECURE}://${GLUETUN_HOST}:${GLUETUN_PORT}/v1/openvpn/portforwarded"


update_port () {
    PORT=$1

    # Clean up cookies file if it exists
    rm -f "$COOKIES"    

    # Log in to the qbittorrent web UI and save cookies
    curl -s -c "$COOKIES" --data "username=$QBITTORRENT_USER&password=$QBITTORRENT_PASS" "${QBITTORRENT_URL_LOGIN}" > /dev/null
    if [ $? -ne 0 ]; then
        echo "Debug | QBITTORRENT_URL_LOGIN: $QBITTORRENT_URL_LOGIN" > /dev/stderr
        echo "Login to qBittorrent failed" > /dev/stderr
        return 1
    fi
    echo "Logged in to qBittorrent"


    # Update qbittorrent preferences with the new port
    curl -s -b "$COOKIES" --data "json={\"listen_port\": \"$PORT\"}" "${QBITTORRENT_URL_SETPREF}" > /dev/null
    if [ $? -ne 0 ]; then
        echo "Debug | QBITTORRENT_URL_SETPREF: $QBITTORRENT_URL_SETPREF" > /dev/stderr
        echo "Failed to update qBittorrent listen port" > /dev/stderr
        return 1
    fi
    echo "Updated qBittorrent listening port to "$PORT

    # Clean up cookies
    rm -f "$COOKIES"

    # Update CURRENT_PORT to the new value
    PORT_CURRENT="$PORT"
}


# Main loop to check the port and update if necessary
while true; do

    # Fetch the forwarded port
    PORT_FORWARDED=$(curl -s ${GLUETUN_URL} | awk -F: '{gsub(/[^0-9]/,"",$2); print $2}')

    # Error if the call failed (curl returned an empty string)
    if [[ -z $PORT_FORWARDED ]]; then
        echo "Debug | PORT_FORWARDED: $PORT_FORWARDED" > /dev/stderr
        echo "Debug | GLUETUN_URL: $GLUETUN_URL" > /dev/stderr
        echo "Unable to reach Gluetun successfully. Check DNS or Container health." > /dev/stderr

        sleep $RECHECK_TIME
        continue
    
    # Check if the fetched port matches PATTERN (regex)
    elif ! [[ "$PORT_FORWARDED" =~ $PATTERN ]]; then
        echo "Debug | PORT_FORWARDED: $PORT_FORWARDED" > /dev/stderr
        echo "Failed to retrieve a valid port number." > /dev/stderr
        
        sleep $RECHECK_TIME
        continue
        
    # If the current port is different from the forwarded port, update it
    elif [[ "$PORT_CURRENT" != "$PORT_FORWARDED" ]]; then
        echo "Attempting to update Listening Port"
        update_port "$PORT_FORWARDED"
    else
        echo "Ports match. No changes required"
    fi


    # Wait for a specific interval before checking again
    echo "Waiting for $RECHECK_TIME seconds"
    sleep $RECHECK_TIME
done
