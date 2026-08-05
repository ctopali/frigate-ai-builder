

echo "Se Exportaron los modelos de yolonas S y L a .onnx exitosamente"

ovc yolo_nas_s_320.onnx --output_model openvino/yolo_nas_s_320.xml
ovc yolo_nas_l_640.onnx --output_model openvino/yolo_nas_l_640.xml

echo "Se transformaron los modelos yolonas.onnx a yolonas.xml correctamente"

# 1. Copiar los archivos desde el PCT 104 hacia el host de Proxmox
pct pull 104 /opt/yolonas/openvino/yolo_nas_s_320.xml /tmp/yolo_nas_s_320.xml
pct pull 104 /opt/yolonas/openvino/yolo_nas_s_320.bin /tmp/yolo_nas_s_320.bin
pct pull 104 /opt/yolonas/openvino/yolo_nas_l_640.xml /tmp/yolo_nas_l_640.xml
pct pull 104 /opt/yolonas/openvino/yolo_nas_l_640.bin /tmp/yolo_nas_l_640.bin

# 2. Copiar los archivos desde el host hacia la carpeta de modelos del PCT 102
pct push 102 /tmp/yolo_nas_s_320.xml /config/model_cache/yolo_nas_s_320.xml
pct push 102 /tmp/yolo_nas_s_320.bin /config/model_cache/yolo_nas_s_320.bin
pct push 102 /tmp/yolo_nas_l_640.xml /config/model_cache/yolo_nas_l_640.xml
pct push 102 /tmp/yolo_nas_l_640.bin /config/model_cache/yolo_nas_l_640.bin

# 3. (Opcional) Limpiar los archivos temporales del host
rm /tmp/yolo_nas_s_320.*
rm /tmp/yolo_nas_l_640.*

pct pull 104 /opt/yolonas/openvino/yolo_nas_l_640.xml /tmp/yolo_nas_l_640.xml
pct pull 104 /opt/yolonas/openvino/yolo_nas_l_640.bin /tmp/yolo_nas_l_640.bin
pct push 102 /tmp/yolo_nas_l_640.xml /config/model_cache/yolo_nas_l_640.xml
pct push 102 /tmp/yolo_nas_l_640.bin /config/model_cache/yolo_nas_l_640.bin
rm /tmp/yolo_nas_l_640.*
echo "Se copiaron correctamente los modelos 
