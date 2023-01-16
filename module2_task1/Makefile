# Implement the next steps for the actual Go-Hugo website's source code

lint: ## Catch such errors without the need to compile or execute the application
	@golangci-lint run ./*.go

build: lint ## Generate the website from markdown and config files in the 'dist/' folder
	@hugo
	@go build -o awesome-api ./*.go

run: ## Run the application in background
	@./awesome-api >./awesome.log 2>&1 &

stop: ## Stop the application with the command kill
	@pkill awesome-api

clean: stop ## Cleanup the content of the 'dist/' folder
	@rm -Rf dist/*
	@rm -f awesome-api awesome.log || true

test: ## Ensure that it behaves as expected
	@echo "# Test 1:"
	@if curl http://localhost:9999; then \
		echo "TESTOK" ;\
	else \
                echo "TESTFAILED" ;\
	fi
	@echo "# Test 2:"
	@if curl http://localhost:9999/health; then \
		echo ""; \
		echo "TESTOK" ;\
	else \
		echo ""; \
		echo "TESTFAILED" ;\
	fi

post: ## Create a new blog post using POST_TITLE and POST_NAME env variables
	@rm -Rf content/posts/$(POST_NAME).md
	@hugo new posts/$(POST_NAME).md
	@sed -i 's/title:.*/title: $(POST_TITLE)/' content/posts/$(POST_NAME).md
	@sed -i 's/draft:.*/draft: "false"/' content/posts/$(POST_NAME).md

help: ## Show this help usage
	@echo "Usage: make <command>"
	@echo "-----"
	@cat Makefile | grep "^\w*:.*##.*" | sed 's/## //'
