-- 01_schema.sql
-- สคริปต์ตัวอย่างสำหรับสร้าง schema/table เริ่มต้น
CREATE SCHEMA IF NOT EXISTS app AUTHORIZATION CURRENT_USER;

CREATE TABLE IF NOT EXISTS app.users (
  id          BIGSERIAL PRIMARY KEY,
  email       CITEXT UNIQUE NOT NULL,
  full_name   TEXT NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ดัชนีตัวอย่าง
CREATE INDEX IF NOT EXISTS idx_users_email ON app.users (email);
