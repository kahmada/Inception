# Variables
DOCKER_COMPOSE = docker compose
DOCKER_COMPOSE_FILE = ./src/docker-compose.yml
DATA_DIR = data

# Default target
all: dirs build up

# Create data directories
dirs:
	@echo "Creating data directories..."
	@mkdir -p "$(DATA_DIR)/wordpress"
	@mkdir -p "$(DATA_DIR)/mariadb"

# Build all Docker images
build:
	@echo "Building Docker images..."
	@if [ ! -f "$(DOCKER_COMPOSE_FILE)" ]; then \
		echo "Error: $(DOCKER_COMPOSE_FILE) does not exist."; \
		exit 1; \
	fi
	@$(DOCKER_COMPOSE) -f "$(DOCKER_COMPOSE_FILE)" build

# Start all containers
up:
	@echo "Starting containers..."
	@$(DOCKER_COMPOSE) -f "$(DOCKER_COMPOSE_FILE)" up -d

# Stop all containers
down:
	@echo "Stopping containers..."
	@$(DOCKER_COMPOSE) -f "$(DOCKER_COMPOSE_FILE)" down

# Remove all containers, networks, volumes
clean:
	@echo "Cleaning up..."
	@$(DOCKER_COMPOSE) -f "$(DOCKER_COMPOSE_FILE)" down --volumes --remove-orphans

# Remove all data
fclean: clean
	@echo "Removing data directories..."
	@rm -rf "$(DATA_DIR)/wordpress"
	@rm -rf "$(DATA_DIR)/mariadb"

# Rebuild everything from scratch
re: fclean all

# Show logs
logs:
	@$(DOCKER_COMPOSE) -f "$(DOCKER_COMPOSE_FILE)" logs -f

# Help message
help:
	@echo "Available commands:"
	@echo "  make          - Create data directories, build images and start containers"
	@echo "  make dirs     - Create data directories"
	@echo "  make build    - Build Docker images"
	@echo "  make up       - Start containers"
	@echo "  make down     - Stop containers"
	@echo "  make clean    - Remove containers, networks, volumes"
	@echo "  make fclean   - Remove containers, networks, volumes and data"
	@echo "  make re       - Rebuild everything from scratch"
	@echo "  make logs     - Show container logs"
	@echo "  make help     - Show this help message"

.PHONY: all dirs build up down clean fclean re logs help
