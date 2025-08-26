FROM dpage/pgadmin4:9.7.0

# กำหนด ENV สำหรับการตั้งค่าบัญชี admin และอื่นๆ
ENV PGADMIN_DEFAULT_EMAIL=admin@example.com \
	PGADMIN_DEFAULT_PASSWORD=admin123 \
	PGADMIN_ENABLE_TLS= \
	PGADMIN_LISTEN_ADDRESS=0.0.0.0 \
	PGADMIN_LISTEN_PORT=80 \
	PGADMIN_SERVER_JSON_FILE=/pgadmin4/servers.json

# เพิ่ม servers.json สำหรับ pre-register server
COPY servers.json /pgadmin4/servers.json

EXPOSE 80

# ตรวจสอบ health ของ service pgAdmin
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
	CMD curl -f http://localhost:80/login || exit 1
