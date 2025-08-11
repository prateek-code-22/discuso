#!/bin/bash
# Build script for Vercel deployment

# Install dependencies
pip install -r requirements.txt

# Run migrations
python manage.py migrate

# Collect static files for production
python manage.py collectstatic --noinput --clear
python manage.py collectstatic --noinput

echo "Static files collected in /staticfiles directory" 