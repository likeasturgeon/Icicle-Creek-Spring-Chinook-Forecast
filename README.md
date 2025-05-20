# IcicleCreekRunForecst
This is a tool and method for forecasting adult salmon returns using PIT tag data. The app was available [here](https://like-a-sturgeon.shinyapps.io/iciclecreekforecast/) but it is currently broken.

This repository contains raw data from white papers published by Leavenworth National Fish Hatchery, and scripts that join the data into a forecast tool. To use this on your own machine, you'll need to branch the whole repository which includes the most recent data sources from US Fish and Wildlife (USFWS). You must have the Shiny and rmarkdown packagase installed with R as well as all dependencies. Running the file "IcicleCreekForecast.rmd" will produce an HTML document that displays a forecast for the current year along with background information and methods for this analysis. The PIT tag data will update automatically based on it's connection to PTAGIS. PIT tagging data and run reconstructions will need to be updated anually as reports are published by USFWS. 

Future work could include a data connection to these reports to fully automate the results. 

At some point PTAGIS switched from an FTP to an API file delivery. This led to the app not working on the hosted site above. However, it should work if you download a branch and run it locally on your computer. 

Wishlist items: 
- Download historical data separately from this years migration data to speed up API download.
- Confidence intervals on the prediction
- Streamline some redundant code. This was my first project and looking back on it - it's messy!
- 