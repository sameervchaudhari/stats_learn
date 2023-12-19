.PHONY: all upgrade-pip install format lint test clean docker-build

# Project setup
PROJECT_NAME = stats_learning
PYTHON = python3
PIP = pip3
DOCKER = docker

# Docker setup (adjust as needed)
DOCKER_TAG = stats_learning:latest
DOCKERFILE = Dockerfile

# Upgrade pip
upgrade-pip:
	$(PIP) install --upgrade pip

# Install dependencies
install:
	$(PIP) install -r requirements.txt

# Format code (adjust command for your formatter, e.g., black)
format:
	$(PYTHON) -m black .

# Lint code (adjust command for your linter, e.g., flake8)
lint:
	$(PYTHON) -m flake8 .

# Run tests
test:
	$(PYTHON) -m unittest discover -s tests

# Clean up
clean:
	find . -type f -name '*.pyc' -delete
	find . -type d -name '__pycache__' -delete
	rm -rf .pytest_cache

# Build Docker image
docker-build:
	$(DOCKER) build -t $(DOCKER_TAG) -f $(DOCKERFILE) .

# All target
all: upgrade-pip install format lint test

