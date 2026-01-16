#!/bin/bash

# Keploy Record Mode Script
# This script starts the application in Keploy record mode to capture API interactions

echo "🎬 Starting Keploy in Record Mode..."
echo "=================================="
echo ""
echo "This will:"
echo "1. Start your application"
echo "2. Record all API calls and database interactions"
echo "3. Save test cases in the 'keploy' directory"
echo ""
echo "After the server starts, make API calls using curl or Postman"
echo "Press Ctrl+C to stop recording"
echo ""

# Ensure keploy directory exists
mkdir -p keploy

# Check if Keploy is installed
if ! command -v keploy &> /dev/null; then
    echo "❌ Keploy is not installed!"
    echo ""
    echo "Install Keploy using one of these methods:"
    echo ""
    echo "Linux/macOS (using curl):"
    echo "  curl -O https://raw.githubusercontent.com/keploy/keploy/main/keploy.sh && source keploy.sh"
    echo ""
    echo "Or install using Docker (see README.md for Docker instructions)"
    exit 1
fi

# Build the application
echo "📦 Building application..."
npm run build

# Run Keploy in record mode
echo ""
echo "🚀 Starting server with Keploy recording..."
echo ""
keploy record -c "npm start" --delay 10

echo ""
echo "✅ Recording session ended"
echo "📁 Test cases saved in ./keploy directory"
