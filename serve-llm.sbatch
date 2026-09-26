#!/bin/bash
#SBATCH --job-name=vllm-server
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=12G
#SBATCH --time=01:00:00
#SBATCH --output=vllm_%j.log

echo "Starting vLLM inference server on node: $(hostname)"
echo "Job ID: $SLURM_JOB_ID"

apptainer exec --nv --bind $PWD:/workspace \
    $PWD/vllm-openai.sif \
    python3 -m vllm.entrypoints.openai.api_server \
    --model facebook/opt-125m \
    --host 0.0.0.0 \
    --port 8000
