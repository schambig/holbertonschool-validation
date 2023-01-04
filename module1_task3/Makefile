# Implement the next steps for the actual Go-Hugo website's source code
build: ## Generate the website from markdown and config files in the 'dist/' folder
	@hugo

clean: ## Cleanup the content of the 'dist/' folder
	@rm -Rf dist/*

post: ## Create a new blog post using POST_TITLE and POST_NAME env variables
	@rm -Rf content/posts/$(POST_NAME).md
	@hugo new posts/$(POST_NAME).md
	@sed -i 's/title:.*/title: $(POST_TITLE)/' content/posts/$(POST_NAME).md
	@sed -i 's/draft:.*/draft: "false"/' content/posts/$(POST_NAME).md

help: ## Show this help usage
	@echo "Usage: make <command>"
	@echo "-----"
	@cat Makefile | grep "^\w*:.*##.*" | sed 's/## //'
