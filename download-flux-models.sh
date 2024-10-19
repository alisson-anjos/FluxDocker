#!/bin/bash

if [[ -z "${HF_TOKEN}" ]] || [[ "${HF_TOKEN}" == "enter_your_huggingface_token_here" ]]
then
    echo "HF_TOKEN is not set, can not download flux because it is a gated repository."
else
    echo "HF_TOKEN is set, checking files..."

    if [[ ! -e "/ComfyUI/models/vae/ae.safetensors" ]]
    then
        echo "Downloading ae.safetensors..."
        wget -O "/ComfyUI/models/vae/ae.safetensors" --header="Authorization: Bearer ${HF_TOKEN}" "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/ae.safetensors?download=true"
    else
        echo "ae.sft already exists, skipping download."
    fi

    if [[ ! -e "/ComfyUI/models/unet/flux1-dev-Q8_0.gguf" ]]
    then
        echo "Downloading flux1-dev-Q8_0.gguf..."
        wget -O "/ComfyUI/models/unet/flux1-dev-Q8_0.gguf" --header="Authorization: Bearer ${HF_TOKEN}" "https://huggingface.co/city96/FLUX.1-dev-gguf/resolve/main/flux1-dev-Q8_0.gguf?download=true"
    else
        echo "flux1-dev-Q8_0.gguf already exists, skipping download."
    fi
fi

# Define the download function
download_file() {
    local dir=$1
    local file=$2
    local url=$3

    mkdir -p $dir
    if [ -f "$dir/$file" ]; then
        echo "File $dir/$file already exists, skipping download."
    else
        wget -O "$dir/$file" "$url" --progress=bar:force:noscroll
    fi
}

# Download files
download_file "/ComfyUI/models/clip" "clip_l.safetensors" "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors?download=true"
download_file "/ComfyUI/models/clip" "t5-v1_1-xxl-encoder-Q8_0.gguf" "https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q8_0.gguf?download=true"