
library(plumber)
library(randomNames)

# not needed but for easy evaluation
library(dplyr) 
library(magrittr)
library(jsonlite)

r <- plumb("R/plumber.R") 
r$run(port = 8000)


