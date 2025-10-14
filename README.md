# Flask CI/CD Application

## Overview

This project demonstrates a complete CI/CD pipeline for a Python Flask application using GitHub Actions, Docker, and AWS EC2.

## Architecture

- **Source Control**: GitHub
- **CI/CD**: GitHub Actions
- **Containerization**: Docker
- **Infrastructure**: AWS EC2
- **Notifications**: Slack

## Local Development

```bash
# Setup virtual environment
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Run tests
pytest

# Run locally
flask run
```
