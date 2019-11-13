import os

#SECRET_KEY_FILE
#LEMUR_SECRET_KEY_FILE
#LEMUR_TOKEN_SECRET_FILE


_basedir = os.path.abspath(os.path.dirname(__file__))

CORS = os.environ.get("LEMUR_CORS") == "True"
debug = os.environ.get("LEMUR_DEBUG") == "True"

secret_key_file = repr(os.environ.get('SECRET_KEY_FILE',''))
if os.path.exists(secret_key_file):
    with open(secret_key_file, 'r') as fh:
        SECRET_KEY = fh.readline()
else:
    SECRET_KEY = repr(os.environ.get('SECRET_KEY_FILE','Hrs8kCDNPuT9vtshsSWzlrYW+d+PrAXvg/HwbRE6M3vzSJTTrA/ZEw=='))

lemur_secret_key_file = repr(os.environ.get('LEMUR_SECRET_KEY_FILE',''))
if os.path.exists(lemur_secret_key_file):
    with open(lemur_secret_key_file, 'r') as fh:
        SECRET_KEY = fh.readline()
else:
    LEMUR_SECRET_KEY = repr(os.environ.get('LEMUR_SECRET_KEY','Hrs8kCDNPuT9vtshsSWzlrYW+d+PrAXvg/HwbRE6M3vzSJTTrA/ZEw=='))

lemur_token_secret_file = repr(os.environ.get('LEMUR_TOKEN_SECRET_FILE',''))
if os.path.exists(lemur_token_secret_file):
    with open(lemur_token_secret_file, 'r') as fh:
        LEMUR_TOKEN_SECRET = fh.readline()
else:
    LEMUR_TOKEN_SECRET = repr(os.environ.get('LEMUR_TOKEN_SECRET','YVKT6nNHnWRWk28Lra1OPxMvHTqg1ZXvAcO7bkVNSbrEuDQPABM0VQ=='))

lemur_secret_key_file = repr(os.environ.get('LEMUR_SECRET_KEY_FILE',''))
if os.path.exists(lemur_secret_key_file):
    with open(lemur_secret_key_file, 'r') as fh:
        SECRET_KEY = fh.readline()
else:
    LEMUR_SECRET_KEY = repr(os.environ.get('LEMUR_SECRET_KEY','Hrs8kCDNPuT9vtshsSWzlrYW+d+PrAXvg/HwbRE6M3vzSJTTrA/ZEw=='))

lemur_encryption_key_file = repr(os.environ.get('LEMUR_ENCRYPTION_KEY_FILE',''))
if os.path.exists(lemur_token_secret_file):
    with open(lemur_token_secret_file, 'r') as fh:
        LEMUR_ENCRYPTION_KEYS = fh.readline()
else:
    LEMUR_ENCRYPTION_KEYS = repr(os.environ.get('LEMUR_ENCRYPTION_KEYS','Ls-qg9j3EMFHyGB_NL0GcQLI6622n9pSyGM_Pu0GdCo='))


LEMUR_WHITELISTED_DOMAINS = []

LEMUR_EMAIL = 'certs@sez23.net'
LEMUR_SECURITY_TEAM_EMAIL = ['certmaster@sez23.net']

LEMUR_DEFAULT_COUNTRY = str(os.environ.get('LEMUR_DEFAULT_COUNTRY','DE'))
LEMUR_DEFAULT_STATE = str(os.environ.get('LEMUR_DEFAULT_STATE','BaWue'))
LEMUR_DEFAULT_LOCATION = str(os.environ.get('LEMUR_DEFAULT_LOCATION','Stuttgart'))
LEMUR_DEFAULT_ORGANIZATION = str(os.environ.get('LEMUR_DEFAULT_ORGANIZATION','Serialize'))
LEMUR_DEFAULT_ORGANIZATIONAL_UNIT = str(os.environ.get('LEMUR_DEFAULT_ORGANIZATIONAL_UNIT','IT'))

import os.path
mail_password_file = repr(os.environ.get('MAIL_PASSWORD_FILE',''))
if os.path.exists(mail_password_file):
    with open(mail_password_file, 'r') as fh:
        mail_password = fh.readline()

    MAIL_SERVER : 'smtp.ionos.de'
    MAIL_PORT : 587
    MAIL_USE_TLS : True
    MAIL_USE_SSL : False
    MAIL_DEBUG : 'app.debug'
    MAIL_USERNAME : 'certmaster@sez23.net'
    MAIL_PASSWORD : mail_password
    MAIL_DEFAULT_SENDER : 'Sez23 Cert Manager'
    # MAIL_MAX_EMAILS : None
    #MAIL_SUPPRESS_SEND : app.testing
    # MAIL_ASCII_ATTACHMENTS : False


ACTIVE_PROVIDERS = []

METRIC_PROVIDERS = []

LOG_LEVEL = str(os.environ.get('LOG_LEVEL','DEBUG'))
LOG_FILE = str(os.environ.get('LOG_FILE','/var/log/lemur/lemur.log'))

db_password_file = repr(os.environ.get('DB_PASSWORD_FILE',''))
if os.path.exists(db_password_file):
    with open(db_password_file, 'r') as fh:
        db_password = fh.readline()
else:
    db_password = 'lemur'

db_user_file = repr(os.environ.get('DB_USER_FILE',''))
if os.path.exists(db_user_file):
    with open(db_user_file, 'r') as fh:
        db_user = fh.readline()
else:
    db_user = 'lemur'

db_host_name = repr(os.environ.get('DB_HOST_NAME','db'))

SQLALCHEMY_DATABASE_URI = 'postgresql://{}:{}@{}:5432/postgres'.format(
    db_user, db_password, db_host_name)

cfssl_host = str(os.environ.get('CFSSL_HOST','ca'))
cfssl_port = int(os.environ.get('CFSSL_PORT','8888'))

CFSSL_URL = 'http://{}:{}'.format(cfssl_host, cfssl_port)

cfssl_root = repr(os.environ.get('CFSSL_ROOT_CERT_FILE',''))
if os.path.exists(cfssl_root):
    with open(cfssl_root, 'r') as fh:
        CFSSL_ROOT = fh.readline()

cfssl_intermediate = str(os.environ.get('CFSSL_INTERMEDIATE_CERT_FILE',''))
if os.path.exists(cfssl_intermediate):
    with open(cfssl_intermediate, 'r') as fh:
        CFSSL_INTERMEDIATE = fh.readline()

cfssl_key_file = str(os.environ.get('CFSSL_KEY_FILE',''))
if os.path.exists(cfssl_key_file):
    with open(cfssl_key_file, 'r') as fh:
        CFSSL_KEY = fh.readline()
