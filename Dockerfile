FROM python:3.12-slim

WORKDIR /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8000 \
    PYTHONPATH=/app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy project
COPY . .

# Set correct permissions
RUN chmod +x start.sh && \
    mkdir -p /app/staticfiles && \
    mkdir -p /app/media && \
    chmod -R 755 /app

# Collect static files
RUN python manage.py collectstatic --noinput

# Expose port
EXPOSE ${PORT}

# Start app
ENTRYPOINT ["/bin/bash", "./start.sh"]
