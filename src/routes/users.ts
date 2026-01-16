import { Router, Request, Response } from 'express';
import prisma from '../db';

const router = Router();

// GET /users - List all users
router.get('/', async (req: Request, res: Response) => {
  try {
    const users = await prisma.user.findMany({
      orderBy: {
        id: 'asc'
      }
    });
    return res.json({
      success: true,
      count: users.length,
      data: users
    });
  } catch (error: any) {
    console.error('Error fetching users:', error);
    return res.status(500).json({ 
      success: false,
      error: 'Failed to fetch users',
      message: error.message 
    });
  }
});

// GET /users/:id - Get a specific user
router.get('/:id', async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const userId = parseInt(id, 10);

    if (isNaN(userId)) {
      return res.status(400).json({ 
        success: false,
        error: 'Invalid user ID' 
      });
    }

    const user = await prisma.user.findUnique({
      where: { id: userId }
    });

    if (!user) {
      return res.status(404).json({ 
        success: false,
        error: 'User not found' 
      });
    }

    return res.json({
      success: true,
      data: user
    });
  } catch (error: any) {
    console.error('Error fetching user:', error);
    return res.status(500).json({ 
      success: false,
      error: 'Failed to fetch user',
      message: error.message 
    });
  }
});

// POST /users - Create a new user
router.post('/', async (req: Request, res: Response) => {
  try {
    const { name, email } = req.body;

    if (!name || typeof name !== 'string' || name.trim() === '') {
      return res.status(400).json({ 
        success: false,
        error: 'Name is required and must be a non-empty string' 
      });
    }

    // Validate email if provided
    if (email && typeof email !== 'string') {
      return res.status(400).json({ 
        success: false,
        error: 'Email must be a string' 
      });
    }

    const user = await prisma.user.create({
      data: {
        name: name.trim(),
        email: email ? email.trim() : null
      }
    });

    return res.status(201).json({
      success: true,
      message: 'User created successfully',
      data: user
    });
  } catch (error: any) {
    console.error('Error creating user:', error);
    
    // Handle unique constraint violation (duplicate email)
    if (error.code === 'P2002') {
      return res.status(409).json({ 
        success: false,
        error: 'Email already exists' 
      });
    }

    return res.status(500).json({ 
      success: false,
      error: 'Failed to create user',
      message: error.message 
    });
  }
});

// PUT /users/:id - Update a user
router.put('/:id', async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const { name, email } = req.body;
    const userId = parseInt(id, 10);

    if (isNaN(userId)) {
      return res.status(400).json({ 
        success: false,
        error: 'Invalid user ID' 
      });
    }

    // Check if user exists
    const existingUser = await prisma.user.findUnique({
      where: { id: userId }
    });

    if (!existingUser) {
      return res.status(404).json({ 
        success: false,
        error: 'User not found' 
      });
    }

    // Validate inputs
    if (name !== undefined && (typeof name !== 'string' || name.trim() === '')) {
      return res.status(400).json({ 
        success: false,
        error: 'Name must be a non-empty string' 
      });
    }

    if (email !== undefined && email !== null && typeof email !== 'string') {
      return res.status(400).json({ 
        success: false,
        error: 'Email must be a string' 
      });
    }

    const user = await prisma.user.update({
      where: { id: userId },
      data: {
        ...(name !== undefined && { name: name.trim() }),
        ...(email !== undefined && { email: email ? email.trim() : null })
      }
    });

    return res.json({
      success: true,
      message: 'User updated successfully',
      data: user
    });
  } catch (error: any) {
    console.error('Error updating user:', error);
    
    // Handle unique constraint violation (duplicate email)
    if (error.code === 'P2002') {
      return res.status(409).json({ 
        success: false,
        error: 'Email already exists' 
      });
    }

    return res.status(500).json({ 
      success: false,
      error: 'Failed to update user',
      message: error.message 
    });
  }
});

// DELETE /users/:id - Delete a user
router.delete('/:id', async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const userId = parseInt(id, 10);

    if (isNaN(userId)) {
      return res.status(400).json({ 
        success: false,
        error: 'Invalid user ID' 
      });
    }

    // Check if user exists
    const existingUser = await prisma.user.findUnique({
      where: { id: userId }
    });

    if (!existingUser) {
      return res.status(404).json({ 
        success: false,
        error: 'User not found' 
      });
    }

    await prisma.user.delete({
      where: { id: userId }
    });

    return res.json({
      success: true,
      message: 'User deleted successfully'
    });
  } catch (error: any) {
    console.error('Error deleting user:', error);
    return res.status(500).json({ 
      success: false,
      error: 'Failed to delete user',
      message: error.message 
    });
  }
});

export default router;
