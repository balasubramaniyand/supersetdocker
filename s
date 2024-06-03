Failed taking a screenshot Message: unknown error: net::ERR_CONNECTION_REFUSED (Session info: headless chrome=115.0.5790.170) 
superset.reports.commands.exceptions.ReportScheduleScreenshotFailedError: Failed taking a screenshot Message: unknown error: net::ERR_CONNECTION_REFUSED
superset_worker         |   (Session info: headless chrome=115.0.5790.170)
import os
from celery.schedules import crontab
from typing import Optional
from cachelib.file import FileSystemCache

# Define the database dialect
DATABASE_DIALECT = 'postgresql'

# Define database connection details
DATABASE_USER = "superset"
DATABASE_PASSWORD = "superset"
DATABASE_HOST = "localhost"
DATABASE_PORT = "5432"
DATABASE_DB = "postgresql"

# Define other configurations
ENABLE_CORS = True
PREFERRED_URL_SCHEME = 'https'
SUPERSET_WEBSERVER_PROTOCOL = "https"
SESSION_COOKIE_SAMESITE = "Lax"
SESSION_COOKIE_SECURE = False
SESSION_COOKIE_HTTPONLY = False
WTF_CSRF_ENABLED = False
ALERT_REPORTS_NOTIFICATION_DRY_RUN = False
ENABLE_PROXY_FIX = True
PROXY_FIX_CONFIG = {"x_for": 1, "x_proto": 1, "x_host": 1, "x_port": 0, "x_prefix": 1}
ENABLE_TEMPLATE_PROCESSING = True
TEMPLATES_EXTENSIONS = ['superset_jinja2_ext']
LOGIN_REDIRECT_URL = '/login'
DISABLED_TOP_LEVEL_NAV_ITEMS = ['Dashboards', 'Charts', 'Data', 'Settings', 'Datasets']

# Define the Redis configuration
REDIS_HOST = os.environ.get("REDIS_HOST")
REDIS_PORT = os.environ.get("REDIS_PORT")
REDIS_CELERY_DB = os.environ.get("REDIS_CELERY_DB", "0")
REDIS_RESULTS_DB = os.environ.get("REDIS_RESULTS_DB", "1")
RESULTS_BACKEND = FileSystemCache("/app/superset_home/sqllab")

# Define the Celery configuration
class CeleryConfig(object):
    BROKER_URL = f"redis://{REDIS_HOST}:{REDIS_PORT}/{REDIS_CELERY_DB}"
    CELERY_IMPORTS = ("superset.sql_lab", "superset.tasks")
    CELERY_RESULT_BACKEND = f"redis://{REDIS_HOST}:{REDIS_PORT}/{REDIS_RESULTS_DB}"
    CELERYD_LOG_LEVEL = "DEBUG"
    CELERYD_PREFETCH_MULTIPLIER = 1
    CELERY_ACKS_LATE = False
    CELERYBEAT_SCHEDULE = {
        "reports.scheduler": {
            "task": "reports.scheduler",
            "schedule": crontab(minute="*", hour="*"),
        },
        "reports.prune_log": {
            "task": "reports.prune_log",
            "schedule": crontab(minute=10, hour=0),
        },
    }

CELERY_CONFIG = CeleryConfig

# Define the SMTP email configuration
SMTP_HOST = "smtp.gmail.com"
SMTP_PORT = 587
SMTP_STARTTLS = True
SMTP_SSL_SERVER_AUTH = True
SMTP_SSL = False
SMTP_USER = "iopexdashboard@gmail.com"
SMTP_PASSWORD = "vxcjhrfvuylgwfcb"
SMTP_MAIL_FROM = "iopexdashboard@gmail.com"
EMAIL_REPORTS_SUBJECT_PREFIX = "[Superset] "
SQLLAB_CTAS_NO_LIMIT = True

# Define the WebDriver configuration
WEBDRIVER_TYPE = "chrome"
WEBDRIVER_OPTION_ARGS = [
    "--force-device-scale-factor=2.0",
    "--high-dpi-support=2.0",
    "--headless",
    "--disable-gpu",
    "--disable-dev-shm-usage",
    "--no-sandbox",
    "--disable-setuid-sandbox",
    "--disable-extensions",
]
WEBDRIVER_BASEURL = "http://superset.localhost:8088/"
SECRET_KEY = "JaTfw+hlw5quXcwKGGqQpFou7pBX55OfEiLHD6ZiHfbVlKidQw2GiG12"

FEATURE_FLAGS = { 
        "ALERT_REPORTS" : True

        }

ENABLE_PROXY_FIX = True
PROXY_FIX_CONFIG = {"x_for": 1, "x_proto": 1, "x_host": 1, "x_port": 0, "x_prefix": 1}
