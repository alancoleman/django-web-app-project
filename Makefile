# Alias
build:
# Docker command
# Speicfy a path to the directory of the Dockerfile, the period at the end of the command is the same directory
# This command contains no target in the options so the whole file will run seqentially
# In the scenario of this project the development image will be built
	docker build --force-rm $(options) -t hackershack-website-tutorial:latest .

build-dev:
# Docker command
# Speicfy a path to the directory of the Dockerfile, the period at the end of the command is the same directory
# This command contains no target in the options so the whole file will run seqentially
# In the scenario of this project the development image will be built
	docker build --force-rm $(options) -t hackershack-website-tutorial:latest .

# This command references the one above, but contains and option to target just the production image build
# In the scenario of this project the production image will be built
build-prod:
	$(MAKE) build options="--target production"

# Docker Compose
# Runs CLI commands for Docker Compose
# up starts up services
# --remove-orphans removes containers that may have been in the last version of the Docker Compose
# https://docs.docker.com/compose/
compose-start:
	docker compose up --remove-orphans $(options)

compose-stop:
	docker compose down --remove-orphans $(options)

# Allows the running of any arbitrary services
compose-manage-py:
	docker compose run --rm $(options) website python manage.py $(cmd)