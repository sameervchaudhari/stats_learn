# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Create and use a non-root user
RUN useradd --create-home appuser
WORKDIR /home/appuser
USER appuser

# Set up a virtual environment
ENV VIRTUAL_ENV=/home/appuser/venv
RUN python -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Copy the current directory contents into the container
COPY --chown=appuser:appuser . .

# Install any needed packages specified in requirements.txt
# Ensure that we use pip and python from the virtual environment
RUN pip install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Run the app
CMD ["python", "app.py"]
