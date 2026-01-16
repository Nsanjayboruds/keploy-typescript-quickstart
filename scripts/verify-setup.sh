#!/bin/bash

# Setup Verification Script
# This script verifies that your environment is ready to run the project

echo "🔍 Keploy TypeScript Quickstart - Setup Verification"
echo "====================================================="
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
CHECKS_PASSED=0
CHECKS_FAILED=0
WARNINGS=0

# Check function
check_command() {
    if command -v $1 &> /dev/null; then
        version=$($1 --version 2>&1 | head -n1)
        echo -e "${GREEN}✓${NC} $1 is installed: $version"
        ((CHECKS_PASSED++))
        return 0
    else
        echo -e "${RED}✗${NC} $1 is not installed"
        ((CHECKS_FAILED++))
        return 1
    fi
}

# Check Node.js
echo "📦 Checking Required Software..."
echo "--------------------------------"

check_command node
if [ $? -eq 0 ]; then
    node_version=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$node_version" -lt 18 ]; then
        echo -e "${YELLOW}⚠${NC}  Node.js version should be 18 or higher"
        ((WARNINGS++))
    fi
fi

check_command npm

echo ""

# Check Optional Software
echo "🔧 Checking Optional Software..."
echo "--------------------------------"

check_command docker
DOCKER_INSTALLED=$?

check_command docker-compose
COMPOSE_INSTALLED=$?

check_command psql
POSTGRES_INSTALLED=$?

check_command keploy
KEPLOY_INSTALLED=$?

echo ""

# Check Project Files
echo "📁 Checking Project Files..."
echo "----------------------------"

files=(
    "package.json"
    "tsconfig.json"
    "src/index.ts"
    "src/routes/users.ts"
    "src/db.ts"
    "prisma/schema.prisma"
    "Dockerfile"
    "docker-compose.yml"
    ".env"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} $file exists"
        ((CHECKS_PASSED++))
    else
        echo -e "${RED}✗${NC} $file is missing"
        ((CHECKS_FAILED++))
    fi
done

echo ""

# Check if node_modules exists
echo "📦 Checking Dependencies..."
echo "---------------------------"

if [ -d "node_modules" ]; then
    echo -e "${GREEN}✓${NC} node_modules directory exists"
    ((CHECKS_PASSED++))
else
    echo -e "${YELLOW}⚠${NC}  node_modules not found - run 'npm install'"
    ((WARNINGS++))
fi

if [ -d "node_modules/.prisma" ]; then
    echo -e "${GREEN}✓${NC} Prisma Client is generated"
    ((CHECKS_PASSED++))
else
    echo -e "${YELLOW}⚠${NC}  Prisma Client not generated - run 'npm run prisma:generate'"
    ((WARNINGS++))
fi

echo ""

# Check if PostgreSQL is running (if installed)
if [ $POSTGRES_INSTALLED -eq 0 ] || [ $DOCKER_INSTALLED -eq 0 ]; then
    echo "🗄️  Checking Database..."
    echo "------------------------"
    
    # Try to connect to PostgreSQL
    if [ $DOCKER_INSTALLED -eq 0 ]; then
        running=$(docker ps --filter "name=keploy-postgres" --format "{{.Names}}" 2>/dev/null)
        if [ ! -z "$running" ]; then
            echo -e "${GREEN}✓${NC} PostgreSQL container is running"
            ((CHECKS_PASSED++))
        else
            echo -e "${YELLOW}⚠${NC}  PostgreSQL container not running - run 'docker-compose up -d postgres'"
            ((WARNINGS++))
        fi
    elif [ $POSTGRES_INSTALLED -eq 0 ]; then
        # Check local PostgreSQL
        if pg_isready &> /dev/null; then
            echo -e "${GREEN}✓${NC} PostgreSQL is running locally"
            ((CHECKS_PASSED++))
        else
            echo -e "${YELLOW}⚠${NC}  PostgreSQL is not running"
            ((WARNINGS++))
        fi
    fi
    echo ""
fi

# Check ports
echo "🔌 Checking Ports..."
echo "--------------------"

check_port() {
    if lsof -Pi :$1 -sTCP:LISTEN -t >/dev/null 2>&1; then
        process=$(lsof -Pi :$1 -sTCP:LISTEN | tail -n1 | awk '{print $1}')
        echo -e "${YELLOW}⚠${NC}  Port $1 is in use by $process"
        ((WARNINGS++))
        return 1
    else
        echo -e "${GREEN}✓${NC} Port $1 is available"
        ((CHECKS_PASSED++))
        return 0
    fi
}

check_port 8000
check_port 5432

echo ""

# Summary
echo "================================================="
echo "📊 Verification Summary"
echo "================================================="
echo ""
echo -e "Checks Passed: ${GREEN}$CHECKS_PASSED${NC}"
echo -e "Checks Failed: ${RED}$CHECKS_FAILED${NC}"
echo -e "Warnings: ${YELLOW}$WARNINGS${NC}"
echo ""

# Recommendations
if [ $CHECKS_FAILED -gt 0 ] || [ $WARNINGS -gt 0 ]; then
    echo "🔧 Recommended Actions:"
    echo "----------------------"
    
    if [ ! -d "node_modules" ]; then
        echo "1. Install dependencies:"
        echo -e "   ${BLUE}npm install${NC}"
    fi
    
    if [ ! -d "node_modules/.prisma" ]; then
        echo "2. Generate Prisma Client:"
        echo -e "   ${BLUE}npm run prisma:generate${NC}"
    fi
    
    if [ $KEPLOY_INSTALLED -ne 0 ]; then
        echo "3. Install Keploy (optional):"
        echo -e "   ${BLUE}curl -O https://raw.githubusercontent.com/keploy/keploy/main/keploy.sh && source keploy.sh${NC}"
    fi
    
    if [ $DOCKER_INSTALLED -ne 0 ]; then
        echo "4. Install Docker (optional but recommended):"
        echo "   Visit: https://docs.docker.com/get-docker/"
    fi
    
    echo ""
fi

# Next Steps
echo "🚀 Next Steps:"
echo "-------------"

if [ $DOCKER_INSTALLED -eq 0 ]; then
    echo "Option 1: Using Docker (Recommended)"
    echo -e "  ${BLUE}docker-compose up -d${NC}"
    echo ""
fi

echo "Option 2: Local Development"
echo -e "  ${BLUE}npm run dev${NC}"
echo ""

if [ $KEPLOY_INSTALLED -eq 0 ]; then
    echo "Option 3: With Keploy"
    echo -e "  ${BLUE}npm run keploy:record${NC}"
    echo ""
fi

# Documentation
echo "📚 Documentation:"
echo "----------------"
echo "  • Quick Start:       GETTING_STARTED.md"
echo "  • Full Guide:        README.md"
echo "  • Quick Reference:   QUICKSTART.md"
echo "  • API Examples:      requests.http"
echo ""

# Exit code
if [ $CHECKS_FAILED -gt 0 ]; then
    echo -e "${RED}⚠️  Some checks failed. Please install missing requirements.${NC}"
    exit 1
else
    echo -e "${GREEN}✅ Your environment is ready!${NC}"
    exit 0
fi
