# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: thuy-ngu <thuy-ngu@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/09 00:00:00 by thuy-ngu          #+#    #+#              #
#    Updated: 2025/08/01 19:40:48 by thuy-ngu         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Project name (not strictly required, but good for reference)
NAME=inception

# Docker Compose command (can be changed to 'docker compose' if using newer versions)
COMPOSE=docker compose

# The main docker-compose file
COMPOSE_FILE=./srcs/docker-compose.yml

# Default target: builds and starts all containers in detached mode
all: up

# Build images and start containers in detached mode
up: certs
	$(COMPOSE) -f $(COMPOSE_FILE) up -d --build

# Stop and remove containers, networks, but keep volumes
# Useful for stopping the project without deleting data
down:
	$(COMPOSE) -f $(COMPOSE_FILE) down

# Rebuild everything from scratch (down then up)
re: down up

# Remove containers, networks, and volumes, and prune unused Docker resources
# This will delete all persistent data (be careful!)
clean:
	$(COMPOSE) -f $(COMPOSE_FILE) down --volumes --remove-orphans
	docker system prune -f

# Updated: Use the correct path to docker-compose.yml in srcs/ for 42 Inception subject compliance
fclean: clean
	$(COMPOSE) -f $(COMPOSE_FILE) down -v --rmi all --remove-orphans
	docker system prune -af
	docker volume prune -f


# Generate self-signed SSL certificates for NGINX
certs:
	@if [ ! -f srcs/requirements/nginx/certs/server.key ] || [ ! -f srcs/requirements/nginx/certs/server.crt ]; then \
		mkdir -p srcs/requirements/nginx/certs; \
		openssl req -x509 -nodes -days 365 \
			-newkey rsa:2048 \
			-keyout srcs/requirements/nginx/certs/server.key \
			-out srcs/requirements/nginx/certs/server.crt \
			-subj "/C=PT/ST=Lisbon/L=Lisbon/O=42/OU=Student/CN=localhost"; \
	fi


logs:
	$(COMPOSE) -f $(COMPOSE_FILE) logs -f

# Declare phony targets (not actual files)
.PHONY: all up down re clean fclean logs