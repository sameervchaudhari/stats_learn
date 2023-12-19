.PHONY: all upgrade-pip install format lint test clean docker-build venv

# Project setup
PROJECT_NAME = stats_learning
PYTHON = python3
PIP = pip3
DOCKER = docker

# Virtual environment setup
VENV = .venv
VENV_ACTIVATE = $(VENV)/bin/activate

# Docker setup (adjust as needed)
DOCKER_TAG = stats_learning:latest
DOCKERFILE = Dockerfile

# Upgrade pip
upgrade-pip:
	$(PIP) install --upgrade pip

# Create a virtual environment
venv:
	$(PYTHON) -m venv $(VENV)

# Install dependencies
install: venv
	. $(VENV_ACTIVATE) && $(PIP) install -r requirements.txt

# Format code (adjust command for your formatter, e.g., black)
format:
	. $(VENV_ACTIVATE) && $(PYTHON) -m black .

# Lint code (adjust command for your linter, e.g., flake8)
lint:
	. $(VENV_ACTIVATE) && $(PYTHON) -m flake8 .

# Run tests
test:
	. $(VENV_ACTIVATE) && $(PYTHON) -m unittest discover -s tests

# Clean up
clean:
	find . -type f -name '*.pyc' -delete
	find . -type d -name '__pycache__' -delete
	rm -rf .pytest_cache $(VENV)

# Build Docker image
docker-build:
	$(DOCKER) build -t $(DOCKER_TAG) -f $(DOCKERFILE) .

# All target
all: upgrade-pip install format lint test
