
library(plumber)
library(randomNames)

r <- plumb("R/plumber.R") 
r$run(port = 8000)

