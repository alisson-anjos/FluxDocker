#!/bin/bash

echo "Downloading all models"

bash download-flux-models.sh
bash download-controlnet.sh
bash download-florence-2.sh
bash download-workflows.sh

echo "All models downloaded"