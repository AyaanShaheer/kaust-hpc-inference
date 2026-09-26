#!/bin/bash
# Mock NovaHPC CLI for Monitoring Slurm Clusters

echo "=========================================="
echo "    NovaHPC - Cluster Health Monitor"
echo "=========================================="
echo ""

echo "Active Workloads:"
squeue -h -o "Job ID: %i | State: %T | Node: %N | Runtime: %M"

echo ""
echo "Node Utilization:"
sinfo -h -N -o "Node: %N | State: %T | CPUs (A/I/O/T): %C" | grep -v "idle"
echo "=========================================="
