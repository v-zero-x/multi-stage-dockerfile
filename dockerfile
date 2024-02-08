# Stage 1: Build
# This stage installs all dependencies and copies your application code
FROM python:3.9-slim as build
WORKDIR /app
COPY requirements.txt .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /app/wheels -r requirements.txt

# Copy application code
COPY /app ./app
COPY /tests ./tests

# Stage 2: Test
# This stage runs your application's tests (assuming you have tests configured)
# For demonstration, this stage might be simplified. Integrate your actual test commands.
FROM build as test
RUN pip install pytest
RUN pytest ./tests

# Stage 3: Staging
# This stage prepares the application for staging, similar to production but may include debug tools
FROM python:3.9-slim as staging
WORKDIR /app
COPY --from=build /app/wheels /wheels
COPY --from=build /app/requirements.txt .
RUN pip install --no-cache /wheels/*
COPY app/ ./app
COPY config/config_staging.py ./config/config_staging.py
CMD ["python", "app/app.py"]

# Stage 4: Production
# This stage prepares the application for production with Gunicorn
FROM staging as production
COPY config/config_production.py ./config/config_production.py

# This CMD is the same as in staging since we're not using Gunicorn.
# For real production use, consider using a WSGI server like Gunicorn.
CMD ["python", "app/app.py"]
