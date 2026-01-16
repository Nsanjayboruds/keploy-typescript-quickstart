# Quick Start Guide

## 🚀 Get Started in 3 Steps

### Step 1: Install Dependencies
```bash
npm install
npm run prisma:generate
```

### Step 2: Start Database
```bash
# Option A: Using Docker (Recommended)
docker-compose up -d postgres

# Option B: Use your local PostgreSQL
# Make sure it's running on port 5432
```

### Step 3: Run the Application
```bash
# Option A: Development Mode
npm run dev

# Option B: Production Mode
npm run build && npm start

# Option C: Docker (Everything)
docker-compose up -d
```

---

## 🎬 Record & Replay with Keploy

### Install Keploy
```bash
curl -O https://raw.githubusercontent.com/keploy/keploy/main/keploy.sh && source keploy.sh
```

### Record Test Cases
```bash
# Start recording
npm run keploy:record

# In another terminal, make API calls
curl -X POST http://localhost:8000/users \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com"}'

curl http://localhost:8000/users

# Press Ctrl+C to stop recording
```

### Replay Test Cases
```bash
npm run keploy:test
```

---

## 🐳 Docker Quick Start

### Record with Docker
```bash
./scripts/docker-record.sh

# Make API calls in another terminal
# Press Ctrl+C to stop
```

### Test with Docker
```bash
./scripts/docker-test.sh
```

---

## 📝 Essential Commands

### Database
```bash
# Push schema to database
npm run prisma:push

# Create a migration
npm run prisma:migrate

# Open Prisma Studio (Database GUI)
npx prisma studio
```

### Development
```bash
# Start dev server (with auto-reload)
npm run dev

# Build TypeScript
npm run build

# Start production server
npm start
```

### Docker
```bash
# Build and start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Reset everything (including database)
docker-compose down -v
```

### Keploy
```bash
# Record mode (local)
npm run keploy:record
./scripts/record.sh

# Test mode (local)
npm run keploy:test
./scripts/test.sh

# Record mode (Docker)
./scripts/docker-record.sh

# Test mode (Docker)
./scripts/docker-test.sh
```

---

## 🧪 Quick Test Sequence

Run this during Keploy record mode:

```bash
# Create users
curl -X POST http://localhost:8000/users -H "Content-Type: application/json" \
  -d '{"name":"Alice","email":"alice@example.com"}'

curl -X POST http://localhost:8000/users -H "Content-Type: application/json" \
  -d '{"name":"Bob","email":"bob@example.com"}'

# List users
curl http://localhost:8000/users

# Get specific user
curl http://localhost:8000/users/1

# Update user
curl -X PUT http://localhost:8000/users/1 -H "Content-Type: application/json" \
  -d '{"name":"Alice Updated"}'

# Delete user
curl -X DELETE http://localhost:8000/users/2

# Verify
curl http://localhost:8000/users
```

---

## ❓ Common Issues

### Port 8000 already in use?
```bash
# Change port in .env
PORT=8080
```

### Database connection failed?
```bash
# Check PostgreSQL is running
docker ps  # If using Docker
sudo systemctl status postgresql  # Linux
brew services list | grep postgres  # macOS
```

### Prisma Client not found?
```bash
npm run prisma:generate
```

---

## 📚 Next Steps

1. ✅ Read the full [README.md](README.md)
2. ✅ Check out [requests.http](requests.http) for sample API calls
3. ✅ Explore [src/routes/users.ts](src/routes/users.ts) for API implementation
4. ✅ Customize the [prisma/schema.prisma](prisma/schema.prisma) for your needs

**Need help?** Check the [Troubleshooting](README.md#troubleshooting) section in README.md
