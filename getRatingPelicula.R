getRatingPelicula <- function(nombrePelicula, a�o, globalConnections)
{
  #nombrePelicula = "SPIDER-MAN"
  #a�o = 2002
  
  numConnections = 0
  isCorrectMovie <- FALSE
  x40 <- c(seq(0, 800, 40))[2:21]
  
  if (TRUE)
  {
    if (is.element(globalConnections, x40))
      Sys.sleep(5)
    retrieved <- fromJSON(paste("https://api.themoviedb.org/3/search/movie?api_key=3ba03dd35bf2a0750d77f5791d309b79&query=", nombrePelicula, sep=''))
    elem4 <- unlist(retrieved[4])
    numConnections = numConnections + 1
    isCorrectMovie <- isCorrectMovie(elem4, a�o)
  }
  
  if (!isCorrectMovie)
  {
    if (is.element(globalConnections, x40))
      Sys.sleep(5)
    retrieved <- fromJSON(paste("https://api.themoviedb.org/3/search/movie?api_key=3ba03dd35bf2a0750d77f5791d309b79&query=", nombrePelicula, " y:", a�o, sep=''))
    elem4 <- unlist(retrieved[4])
    isCorrectMovie <- isCorrectMovie(elem4, a�o)
    numConnections = numConnections + 1
  }
  
  if (!isCorrectMovie)
  {
    if (is.element(globalConnections, x40))
      Sys.sleep(5)
    retrieved <- fromJSON(paste("https://api.themoviedb.org/3/search/movie?api_key=3ba03dd35bf2a0750d77f5791d309b79&query=", nombrePelicula, " ", a�o, sep=''))
    elem4 <- unlist(retrieved[4])
    isCorrectMovie <- isCorrectMovie(elem4, a�o)
    numConnections = numConnections + 1
  }
  
  if (!isCorrectMovie)
  {
    if (is.element(globalConnections, x40))
      Sys.sleep(5)
    retrieved <- fromJSON(paste("https://api.themoviedb.org/3/search/movie?api_key=3ba03dd35bf2a0750d77f5791d309b79&query=", nombrePelicula, " y:", a�o-1, sep=''))
    elem4 <- unlist(retrieved[4])
    isCorrectMovie <- isCorrectMovie(elem4, a�o)
    numConnections = numConnections + 1
  }
  
  if (!isCorrectMovie)
  {
    if (is.element(globalConnections, x40))
      Sys.sleep(5)
    retrieved <- fromJSON(paste("https://api.themoviedb.org/3/search/movie?api_key=3ba03dd35bf2a0750d77f5791d309b79&query=", nombrePelicula, " ", a�o-1, sep=''))
    elem4 <- unlist(retrieved[4])
    isCorrectMovie <- isCorrectMovie(elem4, a�o)
    numConnections = numConnections + 1
  }
  
  if (!isCorrectMovie)
  {
    if (is.element(globalConnections, x40))
      Sys.sleep(5)
    retrieved <- fromJSON(paste("https://api.themoviedb.org/3/search/movie?api_key=3ba03dd35bf2a0750d77f5791d309b79&query=", nombrePelicula, " y:", a�o-2, sep=''))
    elem4 <- unlist(retrieved[4])
    isCorrectMovie <- isCorrectMovie(elem4, a�o)
    numConnections = numConnections + 1
  }
  
  if (!isCorrectMovie)
  {
    if (is.element(globalConnections, x40))
      Sys.sleep(5)
    retrieved <- fromJSON(paste("https://api.themoviedb.org/3/search/movie?api_key=3ba03dd35bf2a0750d77f5791d309b79&query=", nombrePelicula, " ", a�o-2, sep=''))
    elem4 <- unlist(retrieved[4])
    isCorrectMovie <- isCorrectMovie(elem4, a�o)
    numConnections = numConnections + 1
  }
  
  if (isCorrectMovie)
  {
    elementosEliminar <- c(which(grepl("results.vote_count", names(elem4))), 
                           which(grepl("results.id", names(elem4))),
                           which(grepl("results.video", names(elem4))), 
                           which(grepl("results.adult", names(elem4))), 
                           which(grepl("results.overview", names(elem4))), 
                           which(grepl("genre_id", names(elem4))),
                           which(grepl("path", names(elem4)))
                          )
    
    elem4 <- elem4[-elementosEliminar]
    
    x6 <- c(seq(1,length(elem4)+1,6))
    
    matrix <- NULL
    for (i in 1:as.numeric(length(x6)-1))
      matrix <- rbind(matrix, as.data.frame(t(elem4[x6[i]:as.numeric(x6[i+1]-1)])))
    
    fechasVacias<-which(is.element(matrix$results.release_date, c("")))
    matrix$results.release_date <- as.character(matrix$results.release_date)
    matrix$results.release_date[fechasVacias] <- "9999-12-31"
    
    rowPuntuacionCero <- which(matrix$results.vote_average == 0)
    if (length(rowPuntuacionCero) > 0)
      matrix <- matrix[-rowPuntuacionCero,]
    
    releaseYear <- year(matrix$results.release_date)
    rowA�oCorrecto <- which(a�o == releaseYear)
    if (length(rowA�oCorrecto) == 0)
      rowA�oCorrecto <- which(a�o == releaseYear+1)
    if (length(rowA�oCorrecto) == 0)
      rowA�oCorrecto <- which(a�o == releaseYear+2)
    
    matrix <- matrix[rowA�oCorrecto,]
    
    if (nrow(matrix) > 1)
      matrix <- matrix[1,]
    
    matrix<-matrix[c(6, 2, 1, 4, 3, 5)]
    matrix$results.release_date           <- as.Date(matrix$results.release_date)
    matrix$results.title                  <- as.character(matrix$results.title)
    matrix$results.vote_average           <- as.numeric(as.character(matrix$results.vote_average))
    matrix$results.popularity             <- as.numeric(as.character(matrix$results.popularity))
    matrix$results.release.original_title <- as.character(matrix$results.original_title)
    
    colnames(matrix) <- c("Fecha_Release", "T�tulo", "Puntuaci�n", "OL", "Popularidad", "OT")
    
    retorno <- paste(matrix$Puntuaci�n, numConnections, sep="&")
    
    return(retorno)
  }
  else
    return(paste("",numConnections, sep="&"))
}