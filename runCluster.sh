#!/bin/bash
echo "cluster running..."
echo "start manager node"
docker-machine start manager
echo "start manager worker-node1"
docker-machine start worker-node1
echo "start manager worker-node2"
docker-machine start worker-node2
