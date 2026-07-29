#!/usr/bin/env bash

################################################################################
# Frigate AI Builder
# Common Functions
################################################################################

APP_DIR="/opt/ai-model-builder"

################################################################################
# Header
################################################################################

show_header() {

    clear

    echo "===================================================="
    echo "          Frigate AI Model Builder"
    echo "===================================================="
    echo
}

################################################################################
# Pause
################################################################################

pause() {
    echo
    read -rp "Press ENTER to continue..."
}

################################################################################
# Error
################################################################################

error() {

    echo
    echo "ERROR:"
    echo "$1"
    echo

    exit 1
}

################################################################################
# Info
################################################################################

info() {

    echo
    echo "[INFO] $1"
}

################################################################################
# Success
################################################################################

success() {

    echo
    echo "[ OK ] $1"
}

################################################################################
# Docker
################################################################################

check_docker() {

    command -v docker >/dev/null 2>&1 || \
        error "Docker is not installed."

}

################################################################################
# Docker Cleanup
################################################################################

clean_docker() {

    info "Cleaning Docker..."

    docker container prune -f >/dev/null 2>&1

    docker image prune -af >/dev/null 2>&1

    docker builder prune -af >/dev/null 2>&1

    docker volume prune -f >/dev/null 2>&1

    success "Docker cleaned."

}

################################################################################
# Model Size
################################################################################

select_model_size() {

    echo
    echo "Model Size"
    echo
    echo "1) Nano"
    echo "2) Small"
    echo "3) Medium"
    echo "4) Large"
    echo "5) XLarge"
    echo

    read -rp "Select: " OPTION

    case "$OPTION" in
        1) MODEL_SIZE="n" ;;
        2) MODEL_SIZE="s" ;;
        3) MODEL_SIZE="m" ;;
        4) MODEL_SIZE="l" ;;
        5) MODEL_SIZE="x" ;;
        *) error "Invalid model."
    esac

}

################################################################################
# Image Size
################################################################################

select_img_size() {

    echo
    echo "Input Resolution"
    echo
    echo "1) 320"
    echo "2) 416"
    echo "3) 640"
    echo "4) 960"
    echo "5) 1280"
    echo

    read -rp "Select: " OPTION

    case "$OPTION" in
        1) IMG_SIZE=320 ;;
        2) IMG_SIZE=416 ;;
        3) IMG_SIZE=640 ;;
        4) IMG_SIZE=960 ;;
        5) IMG_SIZE=1280 ;;
        *) error "Invalid resolution."
    esac

}

################################################################################
# Timer
################################################################################

timer_start() {

    BUILD_START=$(date +%s)

}

timer_end() {

    BUILD_END=$(date +%s)

    BUILD_TIME=$((BUILD_END-BUILD_START))

    echo
    success "Finished in ${BUILD_TIME} seconds."

}

################################################################################
# Output
################################################################################

check_output() {

    XML=$(find "$APP_DIR/output" -name "*.xml" | head -1)

    BIN=$(find "$APP_DIR/output" -name "*.bin" | head -1)

    if [[ -z "$XML" ]]; then
        error "model.xml not found."
    fi

    if [[ -z "$BIN" ]]; then
        error "model.bin not found."
    fi

    success "OpenVINO model generated."

}

################################################################################
# Logs
################################################################################

log() {

    mkdir -p "$APP_DIR/logs"

    echo "$(date '+%F %T') : $1" \
        >> "$APP_DIR/logs/builder.log"

}
