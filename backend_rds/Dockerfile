# # Use an official Python runtime as a parent image
# FROM python:3.9-slim

# # Set the working directory in the container
# WORKDIR /app

# # Copy the current directory contents into the container at /app
# COPY . .

# # Install any needed packages specified in requirements.txt
# RUN pip install --no-cache-dir -r requirements.txt

# # Make port 8000 available to the world outside this container
# EXPOSE 8000

# # Define environment variable for Django settings module
# ENV DJANGO_SETTINGS_MODULE=backend_rds.settings

# # Run manage.py when the container launches
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

# # # Use the official Python image from the Docker Hub
# # FROM python:3.9-slim

# # # Set environment variables
# # ENV PYTHONDONTWRITEBYTECODE 1
# # ENV PYTHONUNBUFFERED 1

# # # Set the working directory in the container
# # WORKDIR /app

# # # Copy the requirements file into the container
# # COPY requirements.txt /app/

# # # Install dependencies
# # RUN pip install --no-cache-dir -r requirements.txt

# # # Copy the entire project into the container
# # COPY . /app/

# # # Expose the port that Django runs on (default is 8000)
# # EXPOSE 8000

# # # Command to run the application
# # CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

# Use Python image
FROM python:3.9

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app

# Install dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Expose port and set environment variable
EXPOSE 8000

# Run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
