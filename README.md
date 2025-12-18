# Whisper ASR Service

Convert mp3 audio to text using open-iai Whisper ASR

## Usage
1. Run `make up`.
2. Place your audio files in the `input/` directory.
3. Run `make transcribe`

The transcription results (as `.txt` files) will appear in the `output/` directory.


## Overview

The project uses the `onerahmet/openai-whisper-asr-webservice` image to provide a REST API for transcription. It is configured to use GPU acceleration by default.

## Requirements

- [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/)
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) (for GPU support)
- `make` (optional, for using the provided scripts)
- `curl` (for the transcription script)

## Project Structure

```text
.
├── docker-compose.yml    # Docker service definition
├── input/                # Place audio files to be transcribed here
├── Makefile              # Automation scripts for Docker and transcription
├── output/               # Transcription results will be saved here
├── pyproject.toml        # Python project configuration (placeholder)
```
## Scripts

The following commands are available via the `Makefile`:

- `make up`: Starts the ASR service using Docker Compose.
- `make down`: Stops and removes the service containers.
- `make transcribe`: Processes all audio files in the `input/` directory and saves the output to the `output/` directory.
- `make log`: Shows the live logs from the `whisper-asr` container.

## Environment Variables

Configuration is handled in the `docker-compose.yml` file under the `environment` section:

- `ASR_MODEL`: The Whisper model to use (e.g., `tiny`, `base`, `small`, `medium`, `large-v3`, `turbo`). Default is `base`.
- `ASR_ENGINE`: The engine to use (`openai_whisper` or `faster_whisper`). Default is `openai_whisper`.