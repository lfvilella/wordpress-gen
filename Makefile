help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

site: ## Create a new WordPress instance
	@docker network create nginx-gateway | true
	@docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro --network nginx-gateway --restart always nginxproxy/nginx-proxy | true
	@echo "Enter the domain:"; \
	read WP_DOMAIN; \
	mkdir -p sites/$$WP_DOMAIN; \
	cp docker/* sites/$$WP_DOMAIN/; \
	mv sites/$$WP_DOMAIN/template.env sites/$$WP_DOMAIN/.env; \
	echo "WORDPRESS_DOMAIN=$$WP_DOMAIN" >> sites/$$WP_DOMAIN/.env; \
	cd sites/$$WP_DOMAIN; \
	docker-compose up --build -d; \
	cd ../../ ; \
	echo "Please run: sudo echo 127.0.0.1 $$WP_DOMAIN >> /etc/hosts"

.DEFAULT_GOAL := help
