# Keploy TypeScript Quickstart - Project Overview

## What You'll Find Here

This project demonstrates how to use **Keploy** for automated API testing with a real-world TypeScript application.

## Components

### Application Stack
- **Language**: TypeScript
- **Framework**: Express.js
- **Database**: PostgreSQL
- **ORM**: Prisma
- **Testing**: Keploy

### Key Features
✅ Full CRUD API for Users
✅ Type-safe database operations
✅ Docker containerization
✅ Automated test generation with Keploy
✅ Production-ready error handling
✅ Health check endpoints

## Project Files

### Configuration
- `package.json` - Dependencies and npm scripts
- `tsconfig.json` - TypeScript compiler settings
- `.env` - Local environment variables
- `.env.docker` - Docker environment variables
- `docker-compose.yml` - Multi-container orchestration
- `Dockerfile` - Application container image

### Source Code
- `src/index.ts` - Express server and middleware setup
- `src/routes/users.ts` - User API endpoints (CRUD)
- `src/db.ts` - Prisma client instance
- `prisma/schema.prisma` - Database schema definition

### Scripts
- `scripts/record.sh` - Record mode (local)
- `scripts/test.sh` - Test mode (local)
- `scripts/docker-record.sh` - Record mode (Docker)
- `scripts/docker-test.sh` - Test mode (Docker)

### Documentation
- `README.md` - Complete documentation
- `QUICKSTART.md` - Quick start guide
- `requests.http` - Sample API requests (VS Code REST Client)

## How Keploy Works

### Record Mode
1. Start your application with Keploy
2. Make API calls (manually or via scripts)
3. Keploy captures:
   - HTTP requests & responses
   - Database queries & results
   - External API calls
4. Saves everything as test cases

### Test/Replay Mode
1. Keploy starts your application
2. Replays recorded API calls
3. Mocks database responses
4. Compares actual vs recorded responses
5. Shows pass/fail results

## Getting Started

Choose your path:

### Path 1: Local Development
```bash
npm install
npm run prisma:generate
npm run dev
```

### Path 2: Docker (Recommended)
```bash
docker-compose up -d
```

### Path 3: Keploy Testing
```bash
# Record
npm run keploy:record

# Test
npm run keploy:test
```

## API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/health` | GET | Health check |
| `/users` | GET | List all users |
| `/users/:id` | GET | Get user by ID |
| `/users` | POST | Create user |
| `/users/:id` | PUT | Update user |
| `/users/:id` | DELETE | Delete user |

## What Makes This Project Production-Ready?

✅ **Type Safety** - Full TypeScript coverage
✅ **Error Handling** - Comprehensive error responses
✅ **Validation** - Input validation on all endpoints
✅ **Logging** - Request and error logging
✅ **Docker** - Containerized deployment
✅ **Database Migrations** - Prisma schema management
✅ **Graceful Shutdown** - Proper cleanup on exit
✅ **Health Checks** - Docker health monitoring
✅ **Automated Tests** - Keploy test generation

## Beginner-Friendly Features

📖 **Extensive Documentation** - Every step explained
🔧 **Helper Scripts** - Automated common tasks
💡 **Sample Requests** - Ready-to-use curl commands
🐛 **Troubleshooting Guide** - Common issues & solutions
📝 **Code Comments** - Inline explanations
🎯 **Clear Structure** - Organized file layout

## Learning Path

1. **Understand the basics** - Read [QUICKSTART.md](QUICKSTART.md)
2. **Run locally** - Follow [README.md](README.md) setup
3. **Explore the code** - Check `src/` directory
4. **Make API calls** - Use `requests.http` samples
5. **Record tests** - Try Keploy record mode
6. **Run tests** - Execute Keploy test mode
7. **Customize** - Add your own endpoints
8. **Deploy** - Use Docker for production

## Need Help?

- 📖 Read the [README.md](README.md)
- 🚀 Check [QUICKSTART.md](QUICKSTART.md)
- 🐛 See [Troubleshooting](README.md#troubleshooting)
- 📚 Visit [Keploy Docs](https://keploy.io/docs)

## Contributing

Found a bug? Have a suggestion? Contributions welcome!

## License

MIT - Use freely in your projects
