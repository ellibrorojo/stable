getPeliculasFromTemporada <- function(a�o)
{
  url <- generateURL(a�o)
  table <- url %>% read_html() %>%  html_nodes(xpath='//*[@id=\"info\"]/div[2]/table') %>% html_table()
  
  retorno <- as.data.frame(table[1])
  retorno$A�o <- a�o
  retorno$Recaudaci�n <- gsub("\\.", "", retorno$Recaudaci�n)
  retorno$Recaudaci�n <- gsub(",", ".", retorno$Recaudaci�n)
  retorno$RelPib <- round(as.numeric(retorno$Recaudaci�n)/(getPibA�o(getTablaPib(), a�o)*100000), digits=2)
  retorno$Recaudaci�n <- as.numeric(retorno$Recaudaci�n)
  
  return(retorno)
}