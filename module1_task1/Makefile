# Implement the next steps for the actual Go-Hugo website's source code
build:
	@hugo

clean:
	@rm -rf dist/*

post:
	@hugo new posts/$(POST_NAME).md
	@sed -i 's/title:.*/title: $(POST_TITLE)/' content/posts/$(POST_NAME).md
