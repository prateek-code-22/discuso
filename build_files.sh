#!/bin/bash
# Build script for Vercel deployment

# Install dependencies
pip install -r requirements.txt

# Run migrations
python manage.py migrate

# For Vercel, we don't need collectstatic since we're serving from static directory directly
# python manage.py collectstatic --noinput 