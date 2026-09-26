# Distributed LLM Inference on Elastic Slurm (GCP)

This repository contains the infrastructure-as-code (IaC) and job scheduling configurations to deploy a highly available, auto-scaling Slurm cluster on Google Cloud, optimized for AI/ML inference workloads. 

This project demonstrates core competencies required for HPC Support roles, specifically mimicking the operational realities of institutional supercomputers.

## 🏗️ Architecture Overview
* **Infrastructure Provisioning:** Uses Terraform and the Google Cloud HPC Toolkit to deploy a Slurm controller, login node, and a dynamically scaling partition of NVIDIA L4 GPU compute nodes.
* **Shared Storage:** Integrates a basic Filestore NFS tier mounted at `/home`.
* **Workload Containerization:** Utilizes **Apptainer (Singularity)** to securely package and run the `vllm-openai` inference server without requiring root privileges.
* **Job Scheduling:** Uses `sbatch` directives to request GPU resources and launch the distributed LLM workload.
* **Observability:** Includes `nova.sh`, a custom bash script (built upon my existing NovaHPC project) to query `sinfo` and `squeue` for real-time node utilization and job telemetry.

## 🛠️ Real-World Troubleshooting Scenario
During deployment, a submitted batch job stalled in the `PENDING` state. Tracing the Slurm controller logs (`slurmctld.log`) and GCP auto-scaler logs (`resume.log`) revealed a Google Cloud API rejection: `Quota 'GPUS_ALL_REGIONS' exceeded`. This successfully validated the architecture's ability to dispatch jobs to the cloud API layer.
