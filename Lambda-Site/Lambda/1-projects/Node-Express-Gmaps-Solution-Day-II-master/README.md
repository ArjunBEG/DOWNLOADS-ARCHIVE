# Node-Express-Gmaps

Topics:
 * APIs
 * API Documentation
 * Rate Limits
 * Multiple requests

## Objectives
 * Create endpoints
 * Make multpile requests to third-party API
 * Return result

## Beginning Project
 * You will notice there is a config file that is ignored in the .gitignore, which you will be using to store your API key. You will need to import that key into your server file. DO NOT store it anywhere that will get pushed up to your repo.
 * Everything else you will start from scratch.

# Day I

## Project Description
 * You will be using the Google Maps Place API to get details about any place provided by the user of your API. When the user provides you a query (example: `coffee+shops+in+Austin`) you will use that query to make a request to the `Place Search` service, and will specifically be doing a `Text Search Request`. You will use the necessary information from the data returned from that first request, and then do a request to `Place Details` service, returning the detailed information to the user of your API.

## Project Requirements
 * Create an endpoint `/place` that, provided a query, returns the detailed information about the first place that is in the array of places returned to you from `Place Search`.
 * You will be using the `node-fetch` library to make your requests to the `Place Search` API. You can use its example code in its github repo as guidance for its use.

## Stretch Problem
 * Create an endpoint `/places` that, provided a query returns the detailed information about ALL places returned to you from `Place Search`.

## Resources
 * Places API: https://developers.google.com/places/web-service/
 * Place Search: https://developers.google.com/places/web-service/search
 * Place Details: https://developers.google.com/places/web-service/details
 * Request Library: https://github.com/bitinn/node-fetch

# Day II

## Project Requirements
* Create an enpoint called `/travel/mode` that returns the quickest method of travel given two locations, as well as the travel time. It should account for driving, walking, bicycling, and transit.

## Project Notes
* You will need a separate key than what you've used for the Places API since it is actually a different API.
* For best results, try to pick locations that should indeed have transit available.

## Stretch Problem
* Include this comparison information in the information your return from `/place`.

## Resources
 * Distance Matrix API: https://developers.google.com/places/web-service/
 * Travel Mode Section: https://developers.google.com/maps/documentation/distance-matrix/intro#travel_modes
