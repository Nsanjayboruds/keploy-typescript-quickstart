#!/bin/bash

# Docker + Keploy Record Mode Script

echo "🎬 Starting Keploy Record Mode with Docker..."
echo "=============================================="
echo ""

# Build and start services
echo "📦 Building Docker images..."
docker-compose build

echo ""
echo "🚀 Starting PostgreSQL..."
docker-compose up -d postgres

# Wait for PostgreSQL to be ready
echo "⏳ Waiting for PostgreSQL to be ready..."
sleep 5

echo ""
echo "🎬 Starting Keploy in Record Mode..."
echo ""
echo "After the containers start, make API calls to http://localhost:8000"
echo "Press Ctrl+C to stop recording"
echo ""

# Start with record profile
docker-compose --profile record up

echo ""
echo "✅ Recording session ended"
echo "📁 Test cases saved in ./keploy directory"
