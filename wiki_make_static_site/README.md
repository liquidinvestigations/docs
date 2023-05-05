# Github Wiki ---> Static Site

Script to download this repo's wiki and make static site from it.


## Problems

- GitHub accepts lists with `*` and `1.` that don't have an empty line above them. This will not.
- GitHub redirects renamed pages. This donesn't do that, so links are dead.


## Running with Docker

- `./run.sh`

## Running without Docker

- `sudo apt-get install -y zip bash python3-pip`
- `pip install pipenv`
- `pipenv install`
- `pipenv run in-container.sh`


Find output files in `site/`, and a zipped result in `output/`.

