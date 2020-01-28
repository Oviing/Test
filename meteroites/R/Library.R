#R file for all needed libraries
setup <-function(){
  if(!require(devtools)){
    library(devtools)
  }
  if(!require(usethis)){
    library(usethis)
  }
  if(!require(httr)){
    library(httr)
  }
  if(!require(readr)){
    library(readr)
  }
  if(!require(stringdist)){
    library(stringdist)
  }
  if(!require(parallel)){
    library(parallel)
  }
  if(!require(ggplot2)){
    library(ggplot2)
  }
  if(!require(maps)){
    library(maps)
  }
  if(!require(mapproj)){
    library(mapproj)
  }
  if(!require(roxygen2))
    library(roxygen2)
}

