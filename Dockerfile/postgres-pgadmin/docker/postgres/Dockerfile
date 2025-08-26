# syntax=docker/dockerfile:1
FROM postgres:16-alpine

# ติดตั้งยูทิลิตี้ที่จำเป็น (ถ้าต้องใช้เพิ่มเติมให้เพิ่มที่นี่)
RUN apk add --no-cache bash curl tzdata &&         cp /usr/share/zoneinfo/Asia/Bangkok /etc/localtime && echo "Asia/Bangkok" > /etc/timezone

# คัดลอกสคริปต์สำหรับ initialize ฐานข้อมูลครั้งแรก
# ไฟล์ในโฟลเดอร์นี้จะรันโดยอัตโนมัติเมื่อสร้างคลัสเตอร์ใหม่
COPY initdb/ /docker-entrypoint-initdb.d/

# โฟลเดอร์เก็บข้อมูลจริง
VOLUME ["/var/lib/postgresql/data"]

# กำหนด ENV สำหรับตัวแปรที่จำเป็น
ENV POSTGRES_USER=admin \
		POSTGRES_PASSWORD=admin123 \
		POSTGRES_DB=appdb

EXPOSE 5432

# ตรวจสอบ health ของ service postgres
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
	CMD pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB" || exit 1
