send_to_client() {
    if [ "$#" -ne 2 ]; then
        echo "Usage: send_to_client <file_path> <destination_path>"
        return 1
    fi
    
    local file_path="$1"
    local destination_path="$2"
    
    local CLIENT_IP=$(echo $SSH_CLIENT | awk '{print $1}')
    local CLIENT_USER=$(who am i | awk '{print $1}')
    
    if [ -z "$CLIENT_IP" ] || [ -z "$CLIENT_USER" ]; then
        echo "Error: Could not determine client IP or username."
        return 1
    fi

    scp "$file_path" "${CLIENT_USER}@${CLIENT_IP}:$destination_path"
}
