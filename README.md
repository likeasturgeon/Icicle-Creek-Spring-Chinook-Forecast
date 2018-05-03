# IcicleCreekRunForecst
This is a tool and method for forecasting adult salmon returns using PIT tag data. The product is hosted and viewable [here](https://like-a-sturgeon.shinyapps.io/iciclecreekforecast/).

The folder includes raw data obtained from published white papers from Leavenworth National Fish Hatchery, and scripts developed to join the data into a forecast tool. The result is the .rmd file which contains a connection to the PTAGIS database allowing you to get up to date forecast results based on PIT tag detections at Bonneville dam. When run, the file "IcicleCreekForecast.rmd" will produce an HTML document that displays a forecast for the current year along with background information and methods for this analysis. While the PIT tag data will update automatically based on it's connection to PTAGIS other data will need to be updated manually as reports are published. 

Future work could include a data connection to these reports to fully automate the results. Additionally, a shiny web application can be developed and hosted online so that the forecast results can be book marked and your web browser and monitored more easily. 

If you're interested in developing this with me, please let me know.
