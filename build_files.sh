#!/bin/bash
# Build script for Vercel deployment

echo "Installing dependencies..."
python -m pip install --upgrade pip
pip install -r requirements.txt

echo "Collecting static files..."
python manage.py collectstatic --noinput --clear
python manage.py collectstatic --noinput

# Create a success marker
touch /tmp/build-success

echo "Build completed successfully"