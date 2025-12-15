# Use Python 3.9 as the base image
FROM python:3.9

# Set the working directory
WORKDIR /code

# Copy requirements first to cache dependencies
COPY ./requirements.txt /code/requirements.txt

# Install dependencies
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Copy the rest of the application
COPY . /code

# Create specific folders for uploads if they don't exist
# and give them full permissions (Required for Hugging Face)
RUN mkdir -p /code/static/uploads
RUN chmod -R 777 /code/static

# Start the application using Gunicorn on port 7860
# (Hugging Face specifically listens to port 7860, not 5000)
CMD ["gunicorn", "-b", "0.0.0.0:7860", "app:app"]