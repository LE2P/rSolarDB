#' Alias sites from SolarDB
#'
#' This function allow know the alias sites from SolarDB.
#'
#' @return NULL
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#'  sites()
#' }
#'
sites <- function(){

  url <- "https://solardb.univ-reunion.fr/api/v1/data/sites"
  {url %>% .getJSON}$data

}

#' Types from SolarDB
#'
#' This function allow know the types from SolarDB.
#'
#' @return NULL
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#'  sites()
#' }
#'
types <- function(){

  url <- "https://solardb.univ-reunion.fr/api/v1/data/types"
  {url %>% .getJSON}$data

}

#' Sensors from SolarDB
#'
#' This function allow know the sensors ids from SolarDB.
#'
#' @return NULL
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#'  sites()
#' }
#'
sensors <- function(){

  url <- "https://solardb.univ-reunion.fr/api/v1/data/sensors"
  {url %>% .getJSON}$data

}
