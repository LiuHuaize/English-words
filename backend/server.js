const express = require('express');
const cors = require('cors');
const pool = require('./db');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// 测试数据库连接
app.get('/api/test', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()');
    res.json({ 
      success: true, 
      message: '数据库连接正常',
      time: result.rows[0].now 
    });
  } catch (error) {
    res.status(500).json({ 
      success: false, 
      message: '数据库连接失败' 
    });
  }
});

// 用户注册
app.post('/api/register', async (req, res) => {
  const { username, password } = req.body;
  
  if (!username || !password) {
    return res.status(400).json({
      success: false,
      message: '请输入用户名和密码'
    });
  }
  
  if (username.length < 3) {
    return res.status(400).json({
      success: false,
      message: '用户名需要至少3个字符'
    });
  }
  
  if (password.length < 6) {
    return res.status(400).json({
      success: false,
      message: '密码需要至少6个字符'
    });
  }
  
  try {
    // 检查用户名是否已存在
    const checkUser = await pool.query(
      'SELECT id FROM users WHERE LOWER(username) = LOWER($1)',
      [username]
    );
    
    if (checkUser.rows.length > 0) {
      return res.status(400).json({
        success: false,
        message: '这个用户名已经被使用了，请换一个试试'
      });
    }
    
    // 创建新用户
    const newUser = await pool.query(
      'INSERT INTO users (username, password) VALUES ($1, $2) RETURNING id, username, created_at',
      [username, password]
    );
    
    res.status(201).json({
      success: true,
      message: '注册成功！',
      user: {
        id: newUser.rows[0].id,
        username: newUser.rows[0].username,
        createdAt: newUser.rows[0].created_at
      }
    });
    
  } catch (error) {
    console.error('注册错误:', error);
    res.status(500).json({
      success: false,
      message: '注册时出了点问题，请稍后再试'
    });
  }
});

// 用户登录
app.post('/api/login', async (req, res) => {
  const { username, password } = req.body;
  
  if (!username || !password) {
    return res.status(400).json({
      success: false,
      message: '请输入用户名和密码'
    });
  }
  
  try {
    const result = await pool.query(
      'SELECT id, username, created_at FROM users WHERE LOWER(username) = LOWER($1) AND password = $2',
      [username, password]
    );
    
    if (result.rows.length === 0) {
      return res.status(401).json({
        success: false,
        message: '用户名或密码不正确'
      });
    }
    
    res.json({
      success: true,
      message: '登录成功！',
      user: {
        id: result.rows[0].id,
        username: result.rows[0].username,
        createdAt: result.rows[0].created_at
      }
    });
    
  } catch (error) {
    console.error('登录错误:', error);
    res.status(500).json({
      success: false,
      message: '登录时出了点问题，请稍后再试'
    });
  }
});

app.listen(PORT, () => {
  console.log(`服务器运行在 http://localhost:${PORT}`);
  console.log('可用的 API 端点:');
  console.log('  POST /api/register - 用户注册');
  console.log('  POST /api/login - 用户登录');
  console.log('  GET /api/test - 测试数据库连接');
});