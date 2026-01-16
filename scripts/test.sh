#!/bin/bash

# Keploy Test/Replay Mode Script
# This script runs the recorded test cases to verify your application

echo "▶️  Starting Keploy in Test Mode..."
echo "=================================="
echo ""
echo "This will:"
echo "1. Start your application"
echo "2. Replay recorded test cases"
echo "3. Compare responses with recorded data"
echo "4. Generate test report"
echo ""

# Check if test cases exist
if [ ! -d "keploy" ] || [ -z "$(ls -A keploy 2>/dev/null)" ]; then
    echo "❌ No test cases found!"
    echo ""
    echo "Please run record mode first to capture test cases:"
    echo "  npm run keploy:record"
    echo "  or"
    echo "  ./scripts/record.sh"
    exit 1
fi

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

# Run Keploy in test mode
echo ""
echo "🧪 Running tests..."
echo ""
keploy test -c "npm start" --delay 10

echo ""
echo "✅ Test execution completed"
echo "📊 Check the test report for results"
