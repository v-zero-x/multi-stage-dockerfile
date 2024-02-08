# Define variables
IMAGE_NAME=flask-app
STAGING_TAG=staging
PRODUCTION_TAG=production
PORT=8080
STAGING_CONTAINER_NAME=flask-app-staging
PRODUCTION_CONTAINER_NAME=flask-app-production

# Build commands
build-staging:
	@docker build --target staging -t $(IMAGE_NAME):$(STAGING_TAG) .

build-production:
	@docker build --target production -t $(IMAGE_NAME):$(PRODUCTION_TAG) .

# Test commands
test-staging:
	@docker run --rm -d -e APP_ENV=staging --name $(STAGING_CONTAINER_NAME) -p $(PORT):5000 $(IMAGE_NAME):$(STAGING_TAG)
	@echo "Waiting for staging container to start..."
	@sleep 5
	@curl -f http://localhost:$(PORT) || (echo "\nStaging smoke test failed" && docker stop $(STAGING_CONTAINER_NAME) && exit 1)
	@echo "\nStaging smoke test passed"
	# @docker stop $(STAGING_CONTAINER_NAME)

test-production:
	@docker run --rm -d -e APP_ENV=production --name $(PRODUCTION_CONTAINER_NAME) -p $(PORT):5000 $(IMAGE_NAME):$(PRODUCTION_TAG)
	@echo "Waiting for production container to start..."
	@sleep 5
	@curl -f http://localhost:$(PORT) || (echo "\nProduction smoke test failed" && docker stop $(PRODUCTION_CONTAINER_NAME) && exit 1)
	@echo "\nProduction smoke test passed"
	@docker stop $(PRODUCTION_CONTAINER_NAME)

# Run commands
run-staging:
	@echo "Running the staging container..."
	@docker run -d -e APP_ENV=staging --name $(STAGING_CONTAINER_NAME) -p $(PORT):5000 $(IMAGE_NAME):$(STAGING_TAG)

run-production:
	@echo "Running the production container..."
	@docker run -d -e APP_ENV=production --name $(PRODUCTION_CONTAINER_NAME) -p $(PORT):5000 $(IMAGE_NAME):$(PRODUCTION_TAG)

# Clean command
clean:
	@echo "Stopping and removing any running containers..."
	@docker stop $(STAGING_CONTAINER_NAME) || true
	@docker rm $(STAGING_CONTAINER_NAME) || true
	@docker stop $(PRODUCTION_CONTAINER_NAME) || true
	@docker rm $(PRODUCTION_CONTAINER_NAME) || true
	@echo "Clean up completed."

# Help command
help:
	@echo "Available commands:"
	@echo "build-staging    - Build the Docker image for staging."
	@echo "build-production - Build the Docker image for production."
	@echo "test-staging     - Run smoke tests on the staging Docker container."
	@echo "test-production  - Run smoke tests on the production Docker container."
	@echo "clean            - Remove Docker containers and images created during build and test."
	@echo "help             - Display this help message."

# Additional useful commands for development:

# Start a shell inside the staging container for debugging
shell-staging:
	@docker run --rm -it --name $(STAGING_CONTAINER_NAME)-shell -p $(PORT):5000 $(IMAGE_NAME):$(STAGING_TAG) /bin/bash

# Start a shell inside the production container for debugging
shell-production:
	@docker run --rm -it --name $(PRODUCTION_CONTAINER_NAME)-shell -p $(PORT):5000 $(IMAGE_NAME):$(PRODUCTION_TAG) /bin/bash

# Default command
.PHONY: build-staging build-production test-staging test-production clean help shell-staging shell-production
