# Kindle Highlight

This application fetches kindle highlights periodically and display them on the pages.

## Installation

    git clone https://github.com/kyamaguchi/kindle_highlight

## Setup

### Local

#### Fetch highlights

    cp config/application.yml.sample config/application.yml
    amazon_auth
    
    vi config/application.yml
    rake kindle:fetch_highlights

#### Run server

    rake db:migrate
    rails s

Go to http://localhost:3000/admin

### Heroku

Apply environment variables on heroku

    figaro heroku:set -e production

#### Exception notification

If you set `ERROR_MAIL_TO` in `config/application.yml`, exception_notification will be setup.

#### Chrome driver

```
heroku buildpacks:add https://github.com/heroku/heroku-buildpack-chromedriver
heroku buildpacks:add https://github.com/heroku/heroku-buildpack-xvfb-google-chrome
```

## Fetching of kindle highlights

See [kindle_manager](https://github.com/kyamaguchi/kindle_manager) gem for more detail

## Development

### Read emails on web

This app uses letter_opener and letter_opener_web

open http://localhost:3000/letter_opener

## Liscense

MIT

## Others


