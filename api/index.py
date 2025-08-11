import os
import sys
from pathlib import Path

# Add the project root to the Python path
project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root))

# Set Django settings module
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'discuso.settings')

# Import Django and set up the application
import django
django.setup()

from django.core.wsgi import get_wsgi_application
from django.conf import settings

# Get the WSGI application
if settings.DEBUG:
    from django.contrib.staticfiles.handlers import StaticFilesHandler
    application = StaticFilesHandler(get_wsgi_application())
else:
    application = get_wsgi_application()

# Wrap with StaticFilesHandler for development
if os.environ.get('VERCEL_ENV') != 'production':
    application = StaticFilesHandler(application)

# Export for Vercel
app = application 