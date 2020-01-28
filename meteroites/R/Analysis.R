#Analysis of the meteroitesData file
#These functions analyze the mean, min and max mass of the meteroites in the meteroitesData file
#The result will be printed in the console window

meteroites.mean <- function(){
  meteroitesMean <- mean(meteroitesData$mass, na.rm = TRUE)
  sprintf("The average meteroite weights %f gram", meteroitesMean)
}
meteroites.min <- function(){
  meteroitesMin <- min(meteroitesData$mass, na.rm = TRUE)
  sprintf("The smallest meteroite weights %f gram", meteroitesMin)
}

meteroites.max <- function(){
  meteroitesMax <- max(meteroitesData$mass, na.rm = TRUE)
  sprintf("The biggest meteroite weights %f gram", meteroitesMax)
}
