#!/bin/bash

# Apply database migrations
python manage.py migrate --noinput

# Start Gunicorn
exec gunicorn discuso.wsgi:application --bind 0.0.0.0:${PORT:-8000} --workers 2 --threads 2 --timeout 120
