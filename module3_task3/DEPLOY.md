# Operations team's FAQ

## What is in the archive and how to unarchive it?

* In the `awesome-website.zip` archive you will encounter the `dist/` folder
* To unarchive it in your current directory use the command line:
`unzip awesome-website.zip`

## What are the commands to start and stop the application?

* To generate (start) the go-hugo website run the command: `make build`
* To clean (stop) the go-hugo website run the command: `make clean`

## How to customize where the application logs are written?

* You can customize the location of the logs by:

## How to “quickly” verify that the application is running (healthcheck)?

* To veryfy is the go-hugo wesite is runnig correctly run the command:
`hugo server`
* Then verify the status of the website in your localhost by clicking the
`http://localhost:1313/` given by the previous step

## Create a release with the archive and content of DEPLOY.md, triggered by a tag

* Create a `GitHub Release` using the
[“softprops/gh-release” GitHub Action](https://github.com/softprops/action-gh-release)
named `1.0.0` and pointing to the tag `1.0.0`
