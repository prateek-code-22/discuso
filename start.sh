#!/bin/bash

# Wait for database to be ready
python << END
import sys
import time
import psycopg2
from urllib.parse import urlparse
import os

# Get Database URL from environment
db_url = os.environ.get('DATABASE_URL')
if not db_url:
    sys.exit(0)

# Parse URL
result = urlparse(db_url)
dbname = result.path[1:]
user = result.username
password = result.password
host = result.hostname
port = result.port

# Wait for PostgreSQL
for _ in range(10):
    try:
        psycopg2.connect(
            dbname=dbname,
            user=user,
            password=password,
            host=host,
            port=port
        )
        print("Database is ready!")
        break
    except psycopg2.OperationalError:
        print("Waiting for PostgreSQL...")
        time.sleep(3)
END

# Apply database migrations
python manage.py migrate --noinput

# Start Gunicorn with appropriate settings
exec gunicorn discuso.wsgi:application \
    --bind 0.0.0.0:${PORT:-8000} \
    --workers 2 \
    --threads 2 \
    --timeout 120 \
    --max-requests 1200 \
    --max-requests-jitter 50 \
    --log-level info
