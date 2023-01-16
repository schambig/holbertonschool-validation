# Implement the next steps for the actual Go-Hugo website's source code
build: ## Generate the website from markdown and config files in the 'dist/' folder
	@hugo
	@go build -o awesome-api ./*.go

run: ## Run the application in background
	@./awesome-api >./awesome.log 2>&1 &

stop: ## Stop the application with the command kill
	@pkill awesome-api

clean: ## Cleanup the content of the 'dist/' folder
	@rm -Rf dist/*
	@rm -f awesome-api awesome.log || true

test: ## Ensure that it behaves as expected
	@echo "# Test 1"
	@curl http://localhost:9999 || :
	@echo "# Test 2"
	@curl http://localhost:9999/health || :
	@echo ""

post: ## Create a new blog post using POST_TITLE and POST_NAME env variables
	@rm -Rf content/posts/$(POST_NAME).md
	@hugo new posts/$(POST_NAME).md
	@sed -i 's/title:.*/title: $(POST_TITLE)/' content/posts/$(POST_NAME).md
	@sed -i 's/draft:.*/draft: "false"/' content/posts/$(POST_NAME).md

help: ## Show this help usage
	@echo "Usage: make <command>"
	@echo "-----"
	@cat Makefile | grep "^\w*:.*##.*" | sed 's/## //'
