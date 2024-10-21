# Use Python image
FROM python:3.9

# Set working directory
WORKDIR /app

# Copy project files
COPY backend_redis /app

# Install dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Expose port and set environment variable
EXPOSE 8001
ENV DJANGO_SETTINGS_MODULE=backend_redis.settings

# Run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8001"]
