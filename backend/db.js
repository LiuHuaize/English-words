const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT || 5432,
  database: process.env.DB_NAME || 'demosql',
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || '',
});

pool.on('connect', () => {
  console.log('成功连接到 PostgreSQL 数据库');
});

pool.on('error', (err) => {
  console.error('数据库连接错误:', err);
  process.exit(-1);
});

module.exports = pool;