#!/bin/bash

# Test Script - Complete API Testing Sequence
# This script tests all CRUD operations of the Users API

echo "🧪 Keploy TypeScript Quickstart - API Test Suite"
echo "================================================="
echo ""

# Configuration
BASE_URL="http://localhost:8000"
SLEEP_TIME=1

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0

# Function to print test result
print_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ PASSED${NC}: $2"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}✗ FAILED${NC}: $2"
        ((TESTS_FAILED++))
    fi
    echo ""
}

# Function to check if server is running
check_server() {
    echo "🔍 Checking if server is running..."
    response=$(curl -s -o /dev/null -w "%{http_code}" $BASE_URL/health)
    if [ "$response" -eq 200 ]; then
        echo -e "${GREEN}✓ Server is running${NC}"
        echo ""
        return 0
    else
        echo -e "${RED}✗ Server is not responding${NC}"
        echo "Please start the server first:"
        echo "  npm run dev"
        echo "  or"
        echo "  docker-compose up -d"
        exit 1
    fi
}

# Test 1: Health Check
test_health_check() {
    echo "Test 1: Health Check"
    echo "--------------------"
    response=$(curl -s -w "\n%{http_code}" $BASE_URL/health)
    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | sed '$d')
    
    echo "Response: $body"
    
    if [ "$http_code" -eq 200 ]; then
        print_result 0 "Health check endpoint"
    else
        print_result 1 "Health check endpoint (status: $http_code)"
    fi
    
    sleep $SLEEP_TIME
}

# Test 2: Create User - Alice
test_create_user_alice() {
    echo "Test 2: Create User - Alice"
    echo "---------------------------"
    response=$(curl -s -w "\n%{http_code}" -X POST $BASE_URL/users \
        -H "Content-Type: application/json" \
        -d '{"name":"Alice Johnson","email":"alice@example.com"}')
    
    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | sed '$d')
    
    echo "Response: $body"
    
    if [ "$http_code" -eq 201 ]; then
        # Extract user ID for later tests
        USER_ID_ALICE=$(echo "$body" | grep -o '"id":[0-9]*' | grep -o '[0-9]*' | head -1)
        print_result 0 "Create user Alice (ID: $USER_ID_ALICE)"
    else
        print_result 1 "Create user Alice (status: $http_code)"
    fi
    
    sleep $SLEEP_TIME
}

# Test 3: Create User - Bob
test_create_user_bob() {
    echo "Test 3: Create User - Bob"
    echo "-------------------------"
    response=$(curl -s -w "\n%{http_code}" -X POST $BASE_URL/users \
        -H "Content-Type: application/json" \
        -d '{"name":"Bob Smith","email":"bob@example.com"}')
    
    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | sed '$d')
    
    echo "Response: $body"
    
    if [ "$http_code" -eq 201 ]; then
        USER_ID_BOB=$(echo "$body" | grep -o '"id":[0-9]*' | grep -o '[0-9]*' | head -1)
        print_result 0 "Create user Bob (ID: $USER_ID_BOB)"
    else
        print_result 1 "Create user Bob (status: $http_code)"
    fi
    
    sleep $SLEEP_TIME
}

# Test 4: Get All Users
test_get_all_users() {
    echo "Test 4: Get All Users"
    echo "--------------------"
    response=$(curl -s -w "\n%{http_code}" $BASE_URL/users)
    
    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | sed '$d')
    
    echo "Response: $body"
    
    if [ "$http_code" -eq 200 ]; then
        print_result 0 "Get all users"
    else
        print_result 1 "Get all users (status: $http_code)"
    fi
    
    sleep $SLEEP_TIME
}

# Test 5: Get User by ID
test_get_user_by_id() {
    echo "Test 5: Get User by ID"
    echo "----------------------"
    response=$(curl -s -w "\n%{http_code}" $BASE_URL/users/1)
    
    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | sed '$d')
    
    echo "Response: $body"
    
    if [ "$http_code" -eq 200 ]; then
        print_result 0 "Get user by ID"
    else
        print_result 1 "Get user by ID (status: $http_code)"
    fi
    
    sleep $SLEEP_TIME
}

# Test 6: Update User
test_update_user() {
    echo "Test 6: Update User"
    echo "-------------------"
    response=$(curl -s -w "\n%{http_code}" -X PUT $BASE_URL/users/1 \
        -H "Content-Type: application/json" \
        -d '{"name":"Alice Williams","email":"alice.williams@example.com"}')
    
    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | sed '$d')
    
    echo "Response: $body"
    
    if [ "$http_code" -eq 200 ]; then
        print_result 0 "Update user"
    else
        print_result 1 "Update user (status: $http_code)"
    fi
    
    sleep $SLEEP_TIME
}

# Test 7: Delete User
test_delete_user() {
    echo "Test 7: Delete User"
    echo "-------------------"
    response=$(curl -s -w "\n%{http_code}" -X DELETE $BASE_URL/users/2)
    
    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | sed '$d')
    
    echo "Response: $body"
    
    if [ "$http_code" -eq 200 ]; then
        print_result 0 "Delete user"
    else
        print_result 1 "Delete user (status: $http_code)"
    fi
    
    sleep $SLEEP_TIME
}

# Test 8: Verify Deletion
test_verify_deletion() {
    echo "Test 8: Verify Deletion"
    echo "----------------------"
    response=$(curl -s -w "\n%{http_code}" $BASE_URL/users)
    
    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | sed '$d')
    
    echo "Response: $body"
    
    # Check if only one user remains
    user_count=$(echo "$body" | grep -o '"count":[0-9]*' | grep -o '[0-9]*')
    
    if [ "$http_code" -eq 200 ] && [ "$user_count" -eq 1 ]; then
        print_result 0 "Verify deletion (1 user remaining)"
    else
        print_result 1 "Verify deletion (expected 1 user, got $user_count)"
    fi
    
    sleep $SLEEP_TIME
}

# Test 9: Error Handling - Invalid ID
test_error_invalid_id() {
    echo "Test 9: Error Handling - Invalid ID"
    echo "------------------------------------"
    response=$(curl -s -w "\n%{http_code}" $BASE_URL/users/abc)
    
    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | sed '$d')
    
    echo "Response: $body"
    
    if [ "$http_code" -eq 400 ]; then
        print_result 0 "Invalid ID error handling"
    else
        print_result 1 "Invalid ID error handling (status: $http_code)"
    fi
    
    sleep $SLEEP_TIME
}

# Test 10: Error Handling - User Not Found
test_error_not_found() {
    echo "Test 10: Error Handling - User Not Found"
    echo "-----------------------------------------"
    response=$(curl -s -w "\n%{http_code}" $BASE_URL/users/9999)
    
    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | sed '$d')
    
    echo "Response: $body"
    
    if [ "$http_code" -eq 404 ]; then
        print_result 0 "User not found error handling"
    else
        print_result 1 "User not found error handling (status: $http_code)"
    fi
    
    sleep $SLEEP_TIME
}

# Test 11: Error Handling - Missing Name
test_error_missing_name() {
    echo "Test 11: Error Handling - Missing Name"
    echo "---------------------------------------"
    response=$(curl -s -w "\n%{http_code}" -X POST $BASE_URL/users \
        -H "Content-Type: application/json" \
        -d '{"email":"test@example.com"}')
    
    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | sed '$d')
    
    echo "Response: $body"
    
    if [ "$http_code" -eq 400 ]; then
        print_result 0 "Missing name error handling"
    else
        print_result 1 "Missing name error handling (status: $http_code)"
    fi
    
    sleep $SLEEP_TIME
}

# Run all tests
main() {
    check_server
    
    echo "🚀 Running Test Suite..."
    echo ""
    
    test_health_check
    test_create_user_alice
    test_create_user_bob
    test_get_all_users
    test_get_user_by_id
    test_update_user
    test_delete_user
    test_verify_deletion
    test_error_invalid_id
    test_error_not_found
    test_error_missing_name
    
    # Print summary
    echo "================================================="
    echo "📊 Test Summary"
    echo "================================================="
    TOTAL_TESTS=$((TESTS_PASSED + TESTS_FAILED))
    echo "Total Tests: $TOTAL_TESTS"
    echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
    
    if [ $TESTS_FAILED -gt 0 ]; then
        echo -e "${RED}Failed: $TESTS_FAILED${NC}"
        echo ""
        echo -e "${RED}Some tests failed. Please check the output above.${NC}"
        exit 1
    else
        echo -e "${RED}Failed: $TESTS_FAILED${NC}"
        echo ""
        echo -e "${GREEN}🎉 All tests passed!${NC}"
        echo ""
        echo "✨ Next Steps:"
        echo "  1. Try recording these tests with Keploy:"
        echo "     npm run keploy:record"
        echo "  2. Then replay them:"
        echo "     npm run keploy:test"
        exit 0
    fi
}

# Run the test suite
main
