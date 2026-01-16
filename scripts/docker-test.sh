#!/bin/bash

# Docker + Keploy Test Mode Script

echo "▶️  Starting Keploy Test Mode with Docker..."
echo "============================================"
echo ""

# Check if test cases exist
if [ ! -d "keploy" ] || [ -z "$(ls -A keploy 2>/dev/null)" ]; then
    echo "❌ No test cases found!"
    echo ""
    echo "Please run record mode first:"
    echo "  ./scripts/docker-record.sh"
    exit 1
fi

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
echo "🧪 Running tests with Keploy..."
echo ""

# Start with test profile
docker-compose --profile test up

echo ""
echo "✅ Test execution completed"
echo "📊 Check the test report for results"
