# 🚀 Keploy TypeScript Quickstart

A production-ready TypeScript application demonstrating [Keploy](https://keploy.io)'s record and replay functionality with Express.js, PostgreSQL, and Prisma ORM.

## 📋 Table of Contents

- [What is Keploy?](#what-is-keploy)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [API Endpoints](#api-endpoints)
- [Running with Keploy](#running-with-keploy)
- [Docker Setup](#docker-setup)
- [Sample API Usage](#sample-api-usage)
- [Troubleshooting](#troubleshooting)

---

## 🤔 What is Keploy?

**Keploy** is an open-source testing toolkit that records real API interactions and database calls, then replays them as automated tests. Think of it as a "time machine" for your API:

- **Record Mode**: Keploy intercepts your API calls and database queries, saving them as test cases
- **Test/Replay Mode**: Keploy replays the recorded calls and verifies responses match exactly
- **Zero Code Tests**: No need to write test cases manually - they're generated from real traffic!

Perfect for:
- ✅ Regression testing
- ✅ Integration testing
- ✅ API contract testing
- ✅ Catching breaking changes early

---

## ✨ Features

- 🎯 **TypeScript** - Full type safety
- ⚡ **Express.js** - Fast, minimalist web framework
- 🗄️ **PostgreSQL** - Reliable relational database
- 🔄 **Prisma ORM** - Type-safe database client
- 🐳 **Docker** - Containerized deployment
- 🧪 **Keploy** - Automated API testing
- 📝 **Complete CRUD API** - Create, Read, Update, Delete users

---

## 📦 Prerequisites

### Option 1: Local Setup
- [Node.js](https://nodejs.org/) (v18 or higher)
- [PostgreSQL](https://www.postgresql.org/) (v13 or higher)
- [Keploy CLI](https://keploy.io/docs/server/installation/)

### Option 2: Docker Setup (Recommended)
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

---

## 🚀 Quick Start

### Clone and Install

```bash
# Clone the repository
cd kepliy

# Install dependencies
npm install

# Generate Prisma Client
npm run prisma:generate
```

### Local Setup (Without Docker)

1. **Start PostgreSQL**
   
   Make sure PostgreSQL is running on your system.

2. **Configure Environment**
   
   Update [.env](.env) with your database credentials:
   ```env
   DATABASE_URL="postgresql://keploy:keploy123@localhost:5432/keploydb?schema=public"
   PORT=8000
   NODE_ENV=development
   ```

3. **Initialize Database**
   
   ```bash
   # Push schema to database
   npm run prisma:push
   ```

4. **Start the Server**
   
   ```bash
   # Development mode
   npm run dev
   
   # Or production mode
   npm run build
   npm start
   ```

5. **Verify Setup**
   
   Open http://localhost:8000 in your browser or:
   ```bash
   curl http://localhost:8000/health
   ```

---

## 📁 Project Structure

```
keploy-typescript-quickstart/
├── src/
│   ├── index.ts              # Express server setup
│   ├── routes/
│   │   └── users.ts          # User CRUD routes
│   └── db.ts                 # Prisma client instance
├── prisma/
│   └── schema.prisma         # Database schema
├── scripts/
│   ├── record.sh             # Local Keploy record script
│   ├── test.sh               # Local Keploy test script
│   ├── docker-record.sh      # Docker Keploy record script
│   └── docker-test.sh        # Docker Keploy test script
├── Dockerfile                # Container image definition
├── docker-compose.yml        # Multi-container setup
├── package.json              # Dependencies and scripts
├── tsconfig.json             # TypeScript configuration
├── .env                      # Local environment variables
├── .env.docker               # Docker environment variables
└── README.md                 # This file
```

---

## 🌐 API Endpoints

| Method | Endpoint | Description | Request Body |
|--------|----------|-------------|--------------|
| GET | `/` | API information | - |
| GET | `/health` | Health check | - |
| GET | `/users` | List all users | - |
| GET | `/users/:id` | Get user by ID | - |
| POST | `/users` | Create a user | `{ "name": "string", "email": "string" }` |
| PUT | `/users/:id` | Update a user | `{ "name": "string", "email": "string" }` |
| DELETE | `/users/:id` | Delete a user | - |

---

## 🎬 Running with Keploy

### Install Keploy

**Linux/macOS:**
```bash
curl -O https://raw.githubusercontent.com/keploy/keploy/main/keploy.sh && source keploy.sh
```

**Verify Installation:**
```bash
keploy --version
```

### Record Mode

Record API interactions to generate test cases automatically.

**Method 1: Using npm script**
```bash
npm run keploy:record
```

**Method 2: Using shell script**
```bash
./scripts/record.sh
```

**Method 3: Direct command**
```bash
# Build first
npm run build

# Start recording
keploy record -c "npm start" --delay 10
```

**What happens during recording:**
1. Keploy starts your application
2. Your server runs normally on http://localhost:8000
3. Make API calls (see [Sample API Usage](#sample-api-usage))
4. Keploy captures each request/response and database query
5. Test cases are saved in `./keploy` directory
6. Press `Ctrl+C` to stop recording

### Test/Replay Mode

Replay recorded test cases to verify your application.

**Method 1: Using npm script**
```bash
npm run keploy:test
```

**Method 2: Using shell script**
```bash
./scripts/test.sh
```

**Method 3: Direct command**
```bash
keploy test -c "npm start" --delay 10
```

**What happens during testing:**
1. Keploy starts your application
2. Replays all recorded API calls
3. Compares responses with recorded data
4. Shows pass/fail results for each test
5. Generates a detailed test report

**Example Output:**
```
🧪 Running tests...
✅ Test 1: POST /users - PASSED
✅ Test 2: GET /users - PASSED
✅ Test 3: GET /users/1 - PASSED
✅ Test 4: PUT /users/1 - PASSED
✅ Test 5: DELETE /users/1 - PASSED

📊 Results: 5/5 tests passed (100%)
```

---

## 🐳 Docker Setup

Docker provides an isolated, reproducible environment for running the application with Keploy.

### Build and Start Services

```bash
# Build images
docker-compose build

# Start PostgreSQL and App
docker-compose up -d
```

### Keploy Record Mode (Docker)

**Method 1: Using script**
```bash
./scripts/docker-record.sh
```

**Method 2: Direct command**
```bash
docker-compose --profile record up
```

### Keploy Test Mode (Docker)

**Method 1: Using script**
```bash
./scripts/docker-test.sh
```

**Method 2: Direct command**
```bash
docker-compose --profile test up
```

### Useful Docker Commands

```bash
# View logs
docker-compose logs -f app

# Stop all services
docker-compose down

# Remove volumes (reset database)
docker-compose down -v

# Rebuild and restart
docker-compose up -d --build

# Execute commands in container
docker exec -it keploy-app sh
```

---

## 📝 Sample API Usage

### 1. Create a User

```bash
curl -X POST http://localhost:8000/users \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Alice Johnson",
    "email": "alice@example.com"
  }'
```

**Expected Response:**
```json
{
  "success": true,
  "message": "User created successfully",
  "data": {
    "id": 1,
    "name": "Alice Johnson",
    "email": "alice@example.com",
    "createdAt": "2026-01-16T10:30:00.000Z",
    "updatedAt": "2026-01-16T10:30:00.000Z"
  }
}
```

### 2. List All Users

```bash
curl http://localhost:8000/users
```

**Expected Response:**
```json
{
  "success": true,
  "count": 2,
  "data": [
    {
      "id": 1,
      "name": "Alice Johnson",
      "email": "alice@example.com",
      "createdAt": "2026-01-16T10:30:00.000Z",
      "updatedAt": "2026-01-16T10:30:00.000Z"
    },
    {
      "id": 2,
      "name": "Bob Smith",
      "email": "bob@example.com",
      "createdAt": "2026-01-16T10:31:00.000Z",
      "updatedAt": "2026-01-16T10:31:00.000Z"
    }
  ]
}
```

### 3. Get Specific User

```bash
curl http://localhost:8000/users/1
```

**Expected Response:**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "name": "Alice Johnson",
    "email": "alice@example.com",
    "createdAt": "2026-01-16T10:30:00.000Z",
    "updatedAt": "2026-01-16T10:30:00.000Z"
  }
}
```

### 4. Update a User

```bash
curl -X PUT http://localhost:8000/users/1 \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Alice Williams",
    "email": "alice.williams@example.com"
  }'
```

**Expected Response:**
```json
{
  "success": true,
  "message": "User updated successfully",
  "data": {
    "id": 1,
    "name": "Alice Williams",
    "email": "alice.williams@example.com",
    "createdAt": "2026-01-16T10:30:00.000Z",
    "updatedAt": "2026-01-16T10:35:00.000Z"
  }
}
```

### 5. Delete a User

```bash
curl -X DELETE http://localhost:8000/users/1
```

**Expected Response:**
```json
{
  "success": true,
  "message": "User deleted successfully"
}
```

### 6. Complete Test Sequence

Run this sequence during Keploy record mode:

```bash
# 1. Create users
curl -X POST http://localhost:8000/users \
  -H "Content-Type: application/json" \
  -d '{"name": "Alice Johnson", "email": "alice@example.com"}'

curl -X POST http://localhost:8000/users \
  -H "Content-Type: application/json" \
  -d '{"name": "Bob Smith", "email": "bob@example.com"}'

# 2. List all users
curl http://localhost:8000/users

# 3. Get specific user
curl http://localhost:8000/users/1

# 4. Update user
curl -X PUT http://localhost:8000/users/1 \
  -H "Content-Type: application/json" \
  -d '{"name": "Alice Williams"}'

# 5. Delete user
curl -X DELETE http://localhost:8000/users/2

# 6. Verify deletion
curl http://localhost:8000/users
```

---

## 🔍 Understanding the Workflow

### 1️⃣ Record Phase

```
You make API calls → Keploy intercepts → Records request/response → Saves as test case
                                          ↓
                              Also records database queries
```

**Example:**
- You POST to `/users` with name="Alice"
- Keploy records:
  - HTTP request (method, headers, body)
  - HTTP response (status, headers, body)
  - Database INSERT query
  - Database response (generated ID, timestamps)

### 2️⃣ Test/Replay Phase

```
Keploy replays request → Your app processes → Keploy compares → Pass/Fail result
                              ↓
                    Database queries are mocked (using recorded data)
```

**Example:**
- Keploy sends the same POST request
- Your app tries to INSERT into database
- Keploy intercepts and returns the recorded response (same ID, timestamps)
- Keploy compares your app's response with the recorded one
- If they match → ✅ Test passes
- If they differ → ❌ Test fails (with detailed diff)

---

## 🛠️ Troubleshooting

### Issue: "Cannot connect to database"

**Solution:**
```bash
# Check if PostgreSQL is running
sudo systemctl status postgresql  # Linux
brew services list | grep postgres  # macOS

# Verify connection details in .env
# Ensure DATABASE_URL has correct host, port, username, password
```

### Issue: "Keploy command not found"

**Solution:**
```bash
# Reinstall Keploy
curl -O https://raw.githubusercontent.com/keploy/keploy/main/keploy.sh && source keploy.sh

# Verify installation
keploy --version

# Add to PATH if needed
export PATH=$PATH:/usr/local/bin
```

### Issue: "Port 8000 already in use"

**Solution:**
```bash
# Find process using port 8000
lsof -i :8000  # macOS/Linux
netstat -ano | findstr :8000  # Windows

# Kill the process
kill -9 <PID>  # macOS/Linux

# Or change port in .env
PORT=8080
```

### Issue: "Prisma Client not generated"

**Solution:**
```bash
# Generate Prisma Client
npm run prisma:generate

# If still failing, reinstall dependencies
rm -rf node_modules package-lock.json
npm install
npm run prisma:generate
```

### Issue: Docker containers won't start

**Solution:**
```bash
# Check Docker status
docker ps -a

# View container logs
docker-compose logs

# Remove old containers and volumes
docker-compose down -v

# Rebuild from scratch
docker-compose build --no-cache
docker-compose up -d
```

### Issue: Tests failing during replay

**Possible causes:**
1. **Non-deterministic behavior** - Your code uses `Math.random()`, `Date.now()`, or UUIDs
2. **External API calls** - Calling third-party services not mocked by Keploy
3. **Database state changed** - Database has different data than during recording

**Solutions:**
- Use fixed seeds for random values during testing
- Mock external API calls
- Reset database to known state before testing
- Re-record test cases if application logic changed

---

## 📚 Learn More

- [Keploy Documentation](https://keploy.io/docs)
- [Express.js Guide](https://expressjs.com/en/guide/routing.html)
- [Prisma Documentation](https://www.prisma.io/docs)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/intro.html)
- [Docker Compose Documentation](https://docs.docker.com/compose/)

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

## 📄 License

This project is licensed under the MIT License.

---

## 🎉 Next Steps

1. ✅ Get the app running locally
2. ✅ Record your first test case
3. ✅ Run test mode and see 100% pass rate
4. 🚀 Add more complex APIs
5. 🚀 Integrate into CI/CD pipeline
6. 🚀 Share with your team!

**Happy Testing with Keploy! 🎊**

---

## 💡 Tips & Best Practices

- **Record realistic scenarios**: Use production-like data during recording
- **Keep tests isolated**: Each test should be independent
- **Reset state between tests**: Ensure database is in known state
- **Version control test cases**: Commit the `keploy/` directory to git
- **Run tests in CI**: Integrate Keploy into your CI/CD pipeline
- **Update tests when APIs change**: Re-record after making breaking changes

---

## 🐛 Found a Bug?

Please open an issue on GitHub with:
- Steps to reproduce
- Expected behavior
- Actual behavior
- Environment details (OS, Node version, etc.)
