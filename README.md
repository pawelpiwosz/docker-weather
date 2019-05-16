## Weather in terminal

#### Tests status

[![Build Status](https://travis-ci.org/pawelpiwosz/docker-weather.svg?branch=master)](https://travis-ci.org/pawelpiwosz/docker-weather)

#### Synopsis

Print weather for selected location.  
Built based on `wego` ([link to source](https://github.com/schachmat/wego))

#### Build container

```
$ docker build -t wego .
```

This is multistage build for keeping small image size of this app.  
First stage is building the compiler, second the target image with application.
The difference is ~840MB for builder and 21MB for app container.

#### Preparation

According to [documentation](https://github.com/schachmat/wego/README.md),
For using this container you need to generate api key on one of those services:
* [forecast.io](https://developer.forecast.io/register)
* [Openweathermap](https://home.openweathermap.org/users/sign_up)
* [Worldweatheronline](http://www.worldweatheronline.com/)

Today only openweather map is giving free account, forecast.io charges for API
calls.

#### Usage

```
$ docker run --rm wego
```

In order to print help, run

```
$ docker run --rm wego -h
```

In order to print weather for London, use:

```
$ docker run --rm wego -d 3 -l "London" -b openweathermap -owm-api-key <YOUR_API_KEY
```

Where:
`-d` - number of days  
`-l` - location  
`-b` - backend (one of mentioned services)
`-owm-api-key` - API key (in this case for openweathermap)  

#### Problems

* in my case, neither ascii no emoji are displayed ok. Maybe I will fork the
source, maybe not. Who knows.
* It will be nice to create a config file
