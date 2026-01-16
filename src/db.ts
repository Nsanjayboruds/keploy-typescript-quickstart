import { PrismaClient } from '@prisma/client';

// Create a single instance of PrismaClient
const prisma = new PrismaClient({
  log: ['query', 'info', 'warn', 'error'],
});

// Handle cleanup on process termination
process.on('beforeExit', async () => {
  await prisma.$disconnect();
});

export default prisma;
