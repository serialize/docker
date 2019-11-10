import os


_basedir = os.path.abspath(os.path.dirname(__file__))

CORS = os.environ.get("LEMUR_CORS") == "True"
debug = os.environ.get("LEMUR_DEBUG") == "True"

SECRET_KEY = repr(os.environ.get('LEMUR_SECRET_KEY','Hrs8kCDNPuT9vtshsSWzlrYW+d+PrAXvg/HwbRE6M3vzSJTTrA/ZEw=='))

LEMUR_TOKEN_SECRET = repr(os.environ.get('LEMUR_TOKEN_SECRET','YVKT6nNHnWRWk28Lra1OPxMvHTqg1ZXvAcO7bkVNSbrEuDQPABM0VQ=='))
LEMUR_ENCRYPTION_KEYS = repr(os.environ.get('LEMUR_ENCRYPTION_KEYS','Ls-qg9j3EMFHyGB_NL0GcQLI6622n9pSyGM_Pu0GdCo='))

LEMUR_WHITELISTED_DOMAINS = []

LEMUR_EMAIL = ''
LEMUR_SECURITY_TEAM_EMAIL = []

LEMUR_DEFAULT_COUNTRY = repr(os.environ.get('LEMUR_DEFAULT_COUNTRY','DE'))
LEMUR_DEFAULT_STATE = repr(os.environ.get('LEMUR_DEFAULT_STATE','BaWue'))
LEMUR_DEFAULT_LOCATION = repr(os.environ.get('LEMUR_DEFAULT_LOCATION','Stuttgart'))
LEMUR_DEFAULT_ORGANIZATION = repr(os.environ.get('LEMUR_DEFAULT_ORGANIZATION','Serialize'))
LEMUR_DEFAULT_ORGANIZATIONAL_UNIT = repr(os.environ.get('LEMUR_DEFAULT_ORGANIZATIONAL_UNIT','IT'))


# MAIL_SERVER : default ‘localhost’
# MAIL_PORT : default 25
# MAIL_USE_TLS : default False
# MAIL_USE_SSL : default False
# MAIL_DEBUG : default app.debug
# MAIL_USERNAME : default None
# MAIL_PASSWORD : default None
# MAIL_DEFAULT_SENDER : default None
# MAIL_MAX_EMAILS : default None
# MAIL_SUPPRESS_SEND : default app.testing
# MAIL_ASCII_ATTACHMENTS : default False


ACTIVE_PROVIDERS = []

METRIC_PROVIDERS = []

LOG_LEVEL = str(os.environ.get('LOG_LEVEL','DEBUG'))
LOG_FILE = str(os.environ.get('LOG_FILE','/var/log/lemur/lemur.log'))

SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:lemur@db:5432/postgres'

# CFSSL_URL =
# CFSSL_ROOT =
# CFSSL_INTERMEDIATE =
# CFSSL_KEY =
