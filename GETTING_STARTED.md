# 🎯 Getting Started with Keploy TypeScript Quickstart

Welcome! This guide will help you get the project running and understand how Keploy works.

## 📋 What You'll Learn

- ✅ How to set up a TypeScript + Express + PostgreSQL application
- ✅ How to use Keploy to record API tests automatically
- ✅ How to replay tests and verify your application
- ✅ How to use Docker for development and testing

---

## 🏃 Quick Setup (5 Minutes)

### Option 1: Docker (Easiest)

```bash
# 1. Build and start everything
docker-compose up -d

# 2. Check if it's running
curl http://localhost:8000/health

# 3. Test the API
curl -X POST http://localhost:8000/users \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com"}'

# 4. See all users
curl http://localhost:8000/users
```

✅ **Done!** Your API is running at http://localhost:8000

### Option 2: Local Setup

```bash
# 1. Install dependencies
npm install

# 2. Generate Prisma Client
npm run prisma:generate

# 3. Start PostgreSQL (if not already running)
# - macOS: brew services start postgresql
# - Linux: sudo systemctl start postgresql
# - Or use: docker-compose up -d postgres

# 4. Push database schema
npm run prisma:push

# 5. Start the server
npm run dev
```

✅ **Done!** Your API is running at http://localhost:8000

---

## 🎬 Using Keploy (Record & Replay)

### What is Keploy?

Keploy is like a **video recorder for your API**:
- 📹 **Record mode**: Captures all API calls and database queries
- ▶️ **Replay mode**: Plays them back and verifies everything works

### Step 1: Install Keploy

```bash
# Linux/macOS
curl -O https://raw.githubusercontent.com/keploy/keploy/main/keploy.sh && source keploy.sh

# Verify
keploy --version
```

### Step 2: Record Test Cases

```bash
# Start recording
npm run keploy:record
```

**What's happening?**
- ✅ Keploy starts your application
- ✅ Your server runs on http://localhost:8000
- ✅ Keploy is ready to record!

**Now make some API calls** (in a new terminal):

```bash
# Create a user
curl -X POST http://localhost:8000/users \
  -H "Content-Type: application/json" \
  -d '{"name":"Alice","email":"alice@example.com"}'

# List users
curl http://localhost:8000/users

# Get specific user
curl http://localhost:8000/users/1

# Update user
curl -X PUT http://localhost:8000/users/1 \
  -H "Content-Type: application/json" \
  -d '{"name":"Alice Updated"}'

# Delete user
curl -X DELETE http://localhost:8000/users/1
```

**Press Ctrl+C to stop recording**

✅ **Test cases saved!** Check the `keploy/` directory.

### Step 3: Replay Test Cases

```bash
# Run tests
npm run keploy:test
```

**What's happening?**
- ✅ Keploy starts your application
- ✅ Replays all recorded API calls
- ✅ Compares responses with recorded data
- ✅ Shows pass/fail for each test

**Example output:**
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

## 🔍 Understanding the Project

### Project Structure

```
keploy-typescript-quickstart/
├── src/
│   ├── index.ts          ← Express server (entry point)
│   ├── routes/
│   │   └── users.ts      ← User API endpoints
│   └── db.ts             ← Prisma database client
├── prisma/
│   └── schema.prisma     ← Database schema (defines tables)
├── scripts/              ← Helper scripts for Keploy
├── Dockerfile            ← How to build the app container
├── docker-compose.yml    ← Multi-container setup
└── package.json          ← Dependencies and npm scripts
```

### Key Files Explained

**[src/index.ts](src/index.ts)**
- Creates Express server
- Sets up middleware (JSON parsing, CORS)
- Registers routes
- Handles errors

**[src/routes/users.ts](src/routes/users.ts)**
- Defines all User API endpoints
- Handles CRUD operations
- Validates inputs
- Returns proper error messages

**[prisma/schema.prisma](prisma/schema.prisma)**
- Defines database structure
- User table with id, name, email, timestamps
- Prisma generates TypeScript types from this

**[docker-compose.yml](docker-compose.yml)**
- Defines 3 services: app, postgres, keploy
- Sets up networking between containers
- Configures environment variables

---

## 🧪 Testing the API

### Manual Testing

Use the provided test script:

```bash
./scripts/test-api.sh
```

This will:
- ✅ Check if server is running
- ✅ Test all CRUD operations
- ✅ Verify error handling
- ✅ Show pass/fail for each test

### Using VS Code REST Client

1. Install the [REST Client extension](https://marketplace.visualstudio.com/items?itemName=humao.rest-client)
2. Open [requests.http](requests.http)
3. Click "Send Request" above any request

### Using curl

See [README.md](README.md#sample-api-usage) for detailed curl examples.

---

## 🐳 Docker Guide

### Start Everything

```bash
docker-compose up -d
```

This starts:
- ✅ PostgreSQL database on port 5432
- ✅ Your application on port 8000

### View Logs

```bash
# All services
docker-compose logs -f

# Just the app
docker-compose logs -f app

# Just the database
docker-compose logs -f postgres
```

### Stop Everything

```bash
docker-compose down
```

### Reset Database

```bash
# Stop and remove volumes
docker-compose down -v

# Start fresh
docker-compose up -d
```

### Keploy with Docker

**Record Mode:**
```bash
./scripts/docker-record.sh
```

**Test Mode:**
```bash
./scripts/docker-test.sh
```

---

## 🎓 Learning Path

### For Beginners

1. **Start here** → [QUICKSTART.md](QUICKSTART.md)
2. **Run the app** → Follow "Quick Setup" above
3. **Test manually** → Use `./scripts/test-api.sh`
4. **Try Keploy** → Record & replay tests
5. **Read the code** → Start with [src/index.ts](src/index.ts)

### For Intermediate Developers

1. **Understand the stack** → TypeScript, Express, Prisma, PostgreSQL
2. **Review the code** → See how CRUD is implemented
3. **Use Keploy** → Understand record vs replay
4. **Customize** → Add new endpoints
5. **Deploy** → Use Docker in production

### For Advanced Developers

1. **Architecture review** → Evaluate design decisions
2. **Integration testing** → Leverage Keploy in CI/CD
3. **Performance** → Add caching, connection pooling
4. **Security** → Add authentication, rate limiting
5. **Scaling** → Horizontal scaling with Docker

---

## 💡 Common Use Cases

### Use Case 1: Add a New Endpoint

```typescript
// In src/routes/users.ts

// Search users by name
router.get('/search', async (req: Request, res: Response) => {
  const { query } = req.query;
  
  const users = await prisma.user.findMany({
    where: {
      name: {
        contains: query as string,
        mode: 'insensitive'
      }
    }
  });
  
  res.json({ success: true, data: users });
});
```

### Use Case 2: Add a New Table

```prisma
// In prisma/schema.prisma

model Post {
  id        Int      @id @default(autoincrement())
  title     String
  content   String?
  userId    Int
  user      User     @relation(fields: [userId], references: [id])
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  @@map("posts")
}

// Update User model
model User {
  id        Int      @id @default(autoincrement())
  name      String
  email     String?  @unique
  posts     Post[]   // Add this line
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  @@map("users")
}
```

Then run:
```bash
npm run prisma:push
```

### Use Case 3: Test in CI/CD

```yaml
# .github/workflows/test.yml
name: API Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    
    services:
      postgres:
        image: postgres:15-alpine
        env:
          POSTGRES_PASSWORD: postgres
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      
      - name: Install dependencies
        run: npm install
      
      - name: Install Keploy
        run: |
          curl -O https://raw.githubusercontent.com/keploy/keploy/main/keploy.sh
          source keploy.sh
      
      - name: Run Keploy tests
        run: npm run keploy:test
```

---

## 🆘 Need Help?

### Quick Links

- 📖 **Full Documentation**: [README.md](README.md)
- 🚀 **Quick Commands**: [QUICKSTART.md](QUICKSTART.md)
- 📝 **Project Overview**: [OVERVIEW.md](OVERVIEW.md)
- 🐛 **Troubleshooting**: [README.md#troubleshooting](README.md#troubleshooting)

### Common Questions

**Q: How do I change the port?**
A: Edit `.env` and change `PORT=8000` to your desired port.

**Q: How do I reset the database?**
A: Run `docker-compose down -v` then `docker-compose up -d`

**Q: Can I use MySQL instead of PostgreSQL?**
A: Yes! Update `datasource db` in `prisma/schema.prisma` and change the `DATABASE_URL`.

**Q: How do I add authentication?**
A: Check out [Prisma Auth Guide](https://www.prisma.io/docs/guides/database/authentication) or add JWT middleware.

**Q: Where are Keploy test cases stored?**
A: In the `keploy/` directory (automatically created during recording).

---

## 🎯 Next Steps

After completing this guide:

1. ✅ **Experiment** - Modify the code and see what happens
2. ✅ **Add features** - New endpoints, validation, authentication
3. ✅ **Use Keploy** - Integrate into your development workflow
4. ✅ **Deploy** - Use Docker to deploy to production
5. ✅ **Share** - Help others learn from your experience

---

## 🌟 You're Ready!

You now have:
- ✅ A working TypeScript API
- ✅ Automated tests with Keploy
- ✅ Docker containerization
- ✅ Complete CRUD functionality
- ✅ Production-ready setup

**Happy coding! 🚀**
