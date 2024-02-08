import os
from flask import Flask

app = Flask(__name__)

print("\nCurrent WD:", os.getcwd())

# try:
#     app.config.from_pyfile('/app/config/config_staging.py')
# except Exception as e:
#     print(f"Error loading configuration: {e}")

# try:
#     app.config.from_pyfile('config/config_staging.py')
# except Exception as e:
#     print(f"Error loading configuration: {e}")

env = os.getenv('APP_ENV', 'development')

print("\nBefore loading config:", app.config)

try:
    if env == 'production':
        app.config.from_pyfile('/app/config/config_production.py')
    elif env == 'staging':
        app.config.from_pyfile('/app/config/config_staging.py')
    else:
        app.config.from_pyfile('/app/config/config_development.py')
except Exception as e:
    print(f"Error loading configuration: {e}")


print("After loading config:", app.config)

@app.route('/')
def hello_world():
    return 'Hello, World!, APP_ENV: ' + env

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True, port=5000)
