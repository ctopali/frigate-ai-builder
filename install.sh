#!/usr/bin/env bash
set -e

################################################################################
# Frigate AI Builder
################################################################################

APP_DIR="/opt/ai-model-builder"

echo "========================================="
echo " Installing Frigate AI Builder"
echo "========================================="
echo

#
# Verificaciones
#

if [[ $EUID -ne 0 ]]; then
    echo "ERROR: Execute as root."
    exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
    echo "ERROR: Docker is not installed."
    exit 1
fi

echo "[OK] Docker detected."

#
# Directorios
#

echo
echo "Creating directory structure..."

mkdir -p "${APP_DIR}"

mkdir -p "${APP_DIR}/docker"

mkdir -p "${APP_DIR}/docker/yolo11"
mkdir -p "${APP_DIR}/docker/yolonas"
mkdir -p "${APP_DIR}/docker/yolov9"
mkdir -p "${APP_DIR}/docker/rtdetr"

mkdir -p "${APP_DIR}/output"

mkdir -p "${APP_DIR}/logs"

mkdir -p "${APP_DIR}/tmp"

echo "[OK] Directories created."

#
# Permisos
#

chmod -R 755 "${APP_DIR}"

#
# Docker BuildKit
#

mkdir -p /etc/docker

cat >/etc/docker/daemon.json <<EOF
{
    "features": {
        "buildkit": true
    }
}
EOF

systemctl restart docker

echo "[OK] Docker BuildKit enabled."

#
# Final
#

echo
echo "========================================="
echo " Installation completed"
echo "========================================="
echo
echo "Project directory:"
echo
echo "   ${APP_DIR}"
echo
echo "Next step:"
echo
echo "   cd ${APP_DIR}"
echo "   ./build.sh"
echo
