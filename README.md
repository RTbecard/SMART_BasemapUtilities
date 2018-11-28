### SMART Basemap Utilities
A shiny web app to automatically generate georeferenced GIFs compatible with SMART conservation software.  This allows users with no GIS experience to create high quality map backgrounds from satellite or topology for their SMART conservation areas.
The gifs are supplemented by `.proj` and `.grw` (projection and worldfile) files for ESRI style georeferencing.

### Google maps API
Google maps static API no longer allows anonymous requests.
To fetch a map image, you'll have to provide an API token in your code [here](https://github.com/RTbecard/SMART_BasemapUtilities/blob/master/server.R#L13).
Addiitonally, the package `dismo` which I was relying on to do the google map fetch has not been updated (as of writing this) to incorperate these new API changes.
For this basemap app to work, you'll have to install my fork of dismo with the following command:

```r
require(devtools)
install_github("RTbecard/dismo")
```

This fork provides and additional option for the `gmap` command where you can enter your google maps API token, as seen [here](https://github.com/RTbecard/SMART_BasemapUtilities/blob/master/server.R#L47).

If you upload this app to shiny.io, it will recognize that you're installed version of `dismo` was sourced from github and it will try to install that same version, thus you may deploy this on shiny.io and it will use the correct forked version of `dismo` (provided you already installed it on your local machine with the above command).

### Web app

A current deployment of the webapp can be found [here](https://rtbecard.shinyapps.io/smart_basemaputilities/).
