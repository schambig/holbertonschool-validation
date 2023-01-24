.PHONY: build

build: ## Generate the website from markdown and config files in the 'dist/' folder
	@curl -L https://github.com/gohugoio/hugo/releases/download/v0.109.0/hugo_extended_0.109.0_linux-amd64.deb -o hugo.deb
	@apt install ./hugo.deb
	@rm ./hugo.deb
	@hugo
	@touch awesome-api

clean: ## Cleanup the content of the 'dist/' folder
	@rm -Rf dist/*

post: ## Create a new blog post using POST_TITLE and POST_NAME env variables
	@rm -Rf content/posts/$(POST_NAME).md
	@hugo new posts/$(POST_NAME).md
	@sed -i 's/title:.*/title: $(POST_TITLE)/' content/posts/$(POST_NAME).md
	@sed -i 's/draft:.*/draft: "false"/' content/posts/$(POST_NAME).md

package: ## Produce a zip file containing the 'dist/' folder
	@hugo
	@zip -r awesome-website.zip dist/

lint: ## Check markdown files for any syntax mistake
	@apt-get install curl -y
	@curl --silent --location https://deb.nodesource.com/setup_16.x | bash -
	@apt-get install nodejs -y
	@npm install -g markdownlint-cli || true
	@markdownlint README.md DEPLOY.md
	@curl --silent --location https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64 -o hadolint
	@mv hadolint /usr/local/bin/
	@chmod +x /usr/local/bin/hadolint
	@hadolint build/Dockerfile

unit-tests: ## Run unit-tets of the project
	@touch coverage-units.out

integration-tests: ## Run integration-tests of the project
	@touch coverage-integrations.out

validate: ## Validate the project

build-docker: ## Define a docekr image
	@docker build -t awesome:build -f ./build/Dockerfile .

docker-tests: ## Create and test a docker image
	# @docker build -t awesome:build -f ./build/Dockerfile .
	@curl -LO https://storage.googleapis.com/container-structure-test/latest/container-structure-test-linux-amd64
	@chmod +x container-structure-test-linux-amd64
	@sudo mv container-structure-test-linux-amd64 /usr/local/bin/container-structure-test
	@container-structure-test test --image awesome:build --config ./build/cst.yml

help: ## Show help usage
	@echo "Usage: make <command>"
	@echo "-----"
	@fgrep -h "##" Makefile | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//' | head -11
