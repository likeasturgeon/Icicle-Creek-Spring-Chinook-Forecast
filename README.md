# IcicleCreekRunForecst
This is a tool and method for forecasting adult salmon returns using PIT tag data. The app is available [here](https://like-a-sturgeon.shinyapps.io/iciclecreekforecast/).

This repository contains raw data from white papers published by Leavenworth National Fish Hatchery, and scripts that join the data into a forecast tool. To use this on your own machine, you'll need to branch the whole repository which includes the most recent data sources from US Fish and Wildlife (USFWS). You must have the Shiny and rmarkdown packagase installed with R as well as all dependencies. Running the file "IcicleCreekForecast.rmd" will produce an HTML document that displays a forecast for the current year along with background information and methods for this analysis. The PIT tag data will update automatically based on it's connection to PTAGIS. PIT tagging data and run reconstructions will need to be updated anually as reports are published by USFWS. 

Future work could include a data connection to these reports to fully automate the results. 

If you're interested building on this project, let me know.
