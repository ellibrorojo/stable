generateURL <- function (a�o)
{
  a�oActual <- as.numeric(format(Sys.Date(), "%Y"))
  
  if (a�oActual-a�o >= 4)
    url <- as.character(gsub('%s',as.character(a�o),"http://www.mecd.gob.es/cultura-mecd/areas-cultura/cine/mc/cdc/anos-anteriores/ano-%s/cine-peliculas-recaudacion.html"))
  else
    url <- as.character(gsub('%s',as.character(a�o),"http://www.mecd.gob.es/cultura-mecd/areas-cultura/cine/mc/cdc/ano-%s/c/cine-peliculas-recaudacion.html"))
  
  if (a�o == 2013)
    url <- "http://www.mecd.gob.es/cultura-mecd/areas-cultura/cine/mc/cdc/anos-anteriores/ano-2013/c/cine-peliculas-recaudacion.html"
  
  return(url)
}