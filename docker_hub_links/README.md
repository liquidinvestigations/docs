# Docker Hub Readme Writer

Scripts to overwrite Docker Hub repository pages with git repository README.md.

For some reason this is not done automatically from the image repository tags, so we have this script to edit them once...

## Handling Failure to set Readme

Docker Hub silently fails to update the readme page in the following cases:
- readme contains links to: donation pages, monetization, paypal, send me coffee (e.g. pdf2pdfocr, translate repos)
- readme contains profanity or some blacklisted word

This is the case for some of our forks. In that case, manually update the
respective docker hub readme page with a truncated version of the readme,
without offending links/language, and provide a link to the Github repo of the
fork, and also of the fork upstream (original repo).
