# Use PyTorch with CUDA and cuDNN runtime
FROM pytorch/pytorch:2.5.1-cuda12.4-cudnn9-runtime

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install Python dependencies
# We install openai-whisper directly from the source repository as requested
RUN pip3 install --no-cache-dir \
    fastapi \
    uvicorn \
    python-multipart \
    git+https://github.com/openai/whisper.git

# Copy application code
COPY main.py .

# Expose port
EXPOSE 9000

# Command to run the application
CMD ["python3", "main.py"]
