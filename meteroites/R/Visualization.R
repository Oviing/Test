#Visualization of the results

#Histogram of the mass
meteroitesHist <- function(l){
  ggplot() +
    geom_histogram(data = meteroitesData, aes(x = meteroitesData$mass), fill = "blue", colour = "white", show.legend = TRUE) +
    xlim(c(0,l)) +
    labs(x = "Mass", y = "Count")
}

#Plot of the classes
meteroites.plotClass <- function(){
  ggplot()+
    geom_col(data= classDF, aes(x = classDF$classMeteorites, y = classDF$classResultVector), fill = "blue", colour = "white") +
    labs(x = "Classes", y = "Numbers")
}

#Plot location
meteroitesWorld <- function(){
  world <- map_data("world")
  ggplot()+
    geom_polygon(data = world, mapping = aes(x = world$long, y = world$lat, group = group), fill = "lightgrey", colour = "white") +
    geom_point(data = meteroitesData, aes(x = meteroitesData$reclong, y = meteroitesData$reclat), colour = "blue", alpha = 0.3) +
    labs(x = "Long", y = "Lat")
}



