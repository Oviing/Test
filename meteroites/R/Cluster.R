#Cluster analysis of the meteroites
#'\strong{distance}
#'@description
#'The distance function computes the string distances between the classes column of the meteroitesData data frame and pre defined meteroite types.
#'For measuring the distance between to strings the Jaro-Winker distance is used.
#'A value of 1 means there is no similarity between two strings.
#'Vice versa a value of 0 means the similarity between two strings is 100%
#'
#'The function itself creates four variable
#'
#'\code{classMeteroites} contains the general classes of different types of meteroites.
#'\code{vectorClass} is a vector containing charackters, sliced out of the meteroitesData file.
#'\code{distanceMatrix} a matrix ccrated by the stringdistmatrix function
#'\code{distanceMatrixDF} a data frame created from the distanceMatrix variable
#'
#'@usage
#'\code{distance()}
#'@param
#'No additional arguments are used
#'@export
#1. builds a vector with the general classes of different types of meteroites
distance <- function(){
  classMeteorites <- c("CM", "CO", "CI", "CR", "CV", "Diagonite", "EH", "EL","Eucrite", "Acapulcoite", "Achondrite", "Angrite", "Aubrite", "H", "Iron", "L", "Martian", "Mesosiderite", "Others")
  vectorClass <- c(meteroitesData$recclass)
  #The aim is to compare how similar the classes of different meteroites are. To compare the similarity between classes the string distance will be measured
  #3. builds a distanz matrix between the different distances of the general classes in classMeteroites and the registered meteroites classes in the meteroitesDatas set saved in classVector
  #To measure the distance between the strings, the Jaro-Winker distance is used
  #If the distance is 1 no similarity exists. is the distance 0 the similarity is 100%
  distanceMatrix <- stringdistmatrix(classMeteorites, vectorClass, method = "jw", useNames = TRUE)
  #4. converts the distancematrix into a data frame
  distanceMatrixDF <- as.data.frame(distanceMatrix)
  return(distanceMatrixDF)
}


#Using an algorithm to find the smallest value (highest similarity) in each column of the data frame

#create empty  vector with the lenght of classMeteroites
#used for the number of computation per column

#Count the number of columns of the distanceMatrix
#used for the number of repetition of the computation


#Algorithm
#'\strong{cluster}
#'@description
#'cluster is a function to find the minimum value of each column.
#'It creates an empty vector with the same length as the classMeteroites variable.
#'It slice the distanceMatrixDF data frame into single columnns and comparing there every row with the minimum value.
#'If the function find the minimum value it saves the position of the row into the emptyClassMeteroites vector.
#'It returns the emptyClassMeteroites vector
#'
#'WARNING:
#'Just works in combination with the clusterComputation function.
#'@usage
#'\code{cluster{x}}
#'@param
#'x Number of columns of the distanceMatrixDF data frame. The input will be automatically cenerated by the clusterComputation function.
#'@export
cluster <- function(numberOfColumns){
  emptyClassMeteroites <- c(seq(0, 0 , length.out = length(classMeteorites)))
  clusterColumn <- data.frame(distanceMatrixDF[, numberOfColumns])
  i <- 1
  while (length(classMeteorites) > i) {
    if (clusterColumn[i,1] != min(clusterColumn[,1])){
      print(i)
    } else{
      emptyClassMeteroites[i] <- emptyClassMeteroites[i] + 1
      print(i)
      print(emptyClassMeteroites)
    }
    i <- i + 1
  }
  return(emptyClassMeteroites)
}

#use parallel computation for the execution of the algorithm

#'\strong{clusterComputation}
#'@description
#'clusterComputation is a function to cluster the different distances from the \code{distance} function together.
#'To speed up the code the function is using parallel computation.
#'The function first counts the number of columns of the distanceMatrixDF to determine the number of repetitions.
#'It then determine the number of cores in the computer and builds a cluster on each core with respect to one free core.
#'After this the function exports \code{cluster}, \code{distanceMatrixDF}, \code{numberOfColumns}, \code{emptyClassMeteroites}
#'and \code{classMeteroites} to each core.
#'The function uses parSapply to parallel the computation.
#'The function returns the \code{classDF} dat frame with the classes and the number of meteroites in each category and stops automatically the cluster.
#'@usage
#'\code{clusterComputation()}
#'@param
#'No additional arguments are needed
#'@export

clusterComputation <- function(){
  numberOfColumns <- c(1: ncol(distanceMatrix))
  cores <- detectCores()
  buildCluster <- makeCluster(cores - 1)
  clusterExport(buildCluster, "cluster")
  clusterExport(buildCluster, "distanceMatrixDF")
  clusterExport(buildCluster, "numberOfColumns")
  clusterExport(buildCluster, "emptyClassMeteroites")
  clusterExport(buildCluster, "classMeteorites")

  classResult <- parSapply(buildCluster, numberOfColumns, cluster)
  classResultVector <<- rowSums(classResult)
  classDF <<- data.frame(classMeteorites, classResultVector)

  return(classResultVector)
  return(classDF)

  stopCluster(buildCluster)
}




