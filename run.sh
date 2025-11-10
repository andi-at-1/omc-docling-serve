#!/bin/bash

# Parse arguments
PORT=8081  # Default port

while [[ $# -gt 0 ]]; do
  case $1 in
    --port)
      PORT="$2"
      shift
      shift
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: $0 [--port PORT]"
      exit 1
      ;;
  esac
done

export DOCLING_SERVE_ENABLE_REMOTE_SERVICES=true
export DOCLING_SERVE_ARTIFACTS_PATH=/root/models/docling
export DOCLING_SERVE_SCRATCH_PATH=/root/omc-docling-serve/temp
#export UVICORN_WORKERS=5
export DOCLING_NUM_THREADS=62       #cpu workers
export OMP_NUM_THREADS=8            # fallback for thread count
#export DOCLING_SERVE_ENG_LOC_NUM_WORKERS=10
export DOCLING_SERVE_ENG_LOC_SHARE_MODELS=true #alle teilen ein modell
export DOCLING_SERVE_ENABLE_UI=true
export DOCLING_SERVE_LOAD_MODELS_AT_BOOT=true
export DOCLING_SERVE_MAX_SYNC_WAIT=1000
export profile_pipeline_timings=True # gibt mir pipeline stats zurück!

echo "Starting docling-serve on port $PORT..."

#firstrun install & download models in dir:
/root/omc-docling-serve/venv-docling/bin/docling-tools models download --all -o /root/models/docling
/root/omc-docling-serve/venv-docling/bin/docling-serve run --port $PORT --enable-ui


# Here are the main ways to speed up Docling document conversion:

#     Lower the images_scale setting to 1.0 (default) instead of higher values like 2.0—higher values slow down processing and use more memory. Disable generate_page_images and generate_picture_images if you don't need both types of images, and avoid enabling enrichment steps like picture classification or description unless necessary [source].
#     Use hardware acceleration: set accelerator_options to use all CPU cores (num_threads=multiprocessing.cpu_count()) and select the device ('auto', 'cuda' for NVIDIA GPU, 'mps' for Apple Silicon, or 'cpu'). You can also set thread count via environment variables like DOCLING_NUM_THREADS or OMP_NUM_THREADS [source].
#     For PDF conversion, choose the fastest backend: --pdf-backend=pypdfium2 is much faster than the default docling-parse-v2 or docling-parse-v4 [source].
#     Process large files in smaller batches (e.g., using page_range), and consider parallel processing (such as using ThreadPoolExecutor to export pages in parallel) [source].
#     If you deploy Docling as a service, use distributed processing (like docling-serve), and for cloud deployments, pick a plan with more CPU/memory or GPU support.
#     Enable pipeline profiling (profile_pipeline_timings=True) to identify bottlenecks and optimize accordingly [source].
#     For GPU acceleration, use CUDA-enabled Docker images and verify GPU detection with nvidia-smi [source].

# Most of these options can be set via pipeline configuration, CLI flags, or environment variables. Let me know if you need example code or CLI commands for your specific setup.