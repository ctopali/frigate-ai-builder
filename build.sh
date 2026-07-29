#!/usr/bin/env bash
set -e

APP_DIR="/opt/ai-model-builder"

clear

while true; do
    echo "===================================================="
    echo "           Frigate AI Model Builder"
    echo "===================================================="
    echo
    echo "  1) YOLO11"
    echo "  2) YOLO-NAS"
    echo "  3) YOLOv9 (Legacy)"
    echo "  4) RT-DETR"
    echo
    echo "----------------------------------------------------"
    echo
    echo "  5) Listar modelos generados"
    echo "  6) Limpiar caché Docker"
    echo "  7) Actualizar repositorio"
    echo
    echo "  0) Salir"
    echo
    read -rp "Seleccione una opción: " OPTION
    echo

    case "$OPTION" in

        1)
            bash "$APP_DIR/docker/yolo11/build.sh"
            ;;

        2)
            bash "$APP_DIR/docker/yolonas/build.sh"
            ;;

        3)
            bash "$APP_DIR/docker/yolov9/build.sh"
            ;;

        4)
            bash "$APP_DIR/docker/rtdetr/build.sh"
            ;;

        5)
            echo
            echo "==============================="
            echo " Modelos disponibles"
            echo "==============================="
            echo

            if [ -z "$(ls -A "$APP_DIR/output" 2>/dev/null)" ]; then
                echo "No existen modelos."
            else
                find "$APP_DIR/output" -maxdepth 2 -type f
            fi

            echo
            read -rp "Presione ENTER..."
            ;;

        6)
            echo
            echo "Limpiando Docker..."
            docker container prune -f
            docker image prune -af
            docker builder prune -af
            docker volume prune -f
            echo
            read -rp "Presione ENTER..."
            ;;

        7)
            echo
            git -C "$APP_DIR" pull
            echo
            read -rp "Presione ENTER..."
            ;;

        0)
            clear
            exit 0
            ;;

        *)
            echo
            echo "Opción inválida."
            sleep 2
            ;;
    esac

    clear

done
