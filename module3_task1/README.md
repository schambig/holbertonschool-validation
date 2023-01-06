# Awesome Inc. website Docs
Welcome to our site, please follow the next information in order to have a working website.

## Prerequisites
- Hugo v0.80+ must be used.
- Usage of Git Submodules is prohibited.
- Use the theme "ananke" for the website by following:
	- `Note for non-git users` at the [Step 3](https://docs.edg.io/guides/sites_frameworks/getting_started/hugo).
- The website is expected to be generated into ./dist folder but this folder should be **absent** from the repo.

## Lifecycle
- post
- build
- clean
- help

## Build Workflow
- The workflow is executed into an Ubuntu 18.04 execution environment
- Required tools are installed prior to any `make` target, by executing the script `setup.sh`
