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
sites <- function() {
  url <- "https://solardb.univ-reunion.fr/api/v1/data/sites"
  url %>% .getJSON

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
types <- function() {
  url <- "https://solardb.univ-reunion.fr/api/v1/data/types"
  url %>% .getJSON

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
sensors <- function() {
  url <- "https://solardb.univ-reunion.fr/api/v1/data/sensors"
  url %>% .getJSON

}


#' Get data from SolarDB
#'
#' This function allow query the data from SolarDB.
#'
#' @return NULL
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#'  getData()
#' }
#'
getData <- function(sites = NULL, types = NULL, sensors = NULL, start = NULL, stop = NULL) {
    if (is.null(sites) && is.null(types) && is.null(sensors)) {
      message("Please set a least one {site} OR one {type} OR one {sensor}")
      return(invisible(NULL))
    }

    if (!is.null(sites))
      sites <- paste0("site=", paste(sites, collapse = ","))

    if (!is.null(types))
      types <- paste0("type=", paste(types, collapse = ","))

    if (!is.null(sensors))
      sensors <- paste0("sensorid=", paste(sensors, collapse = ","))

    if (!is.null(start))
      start <- paste0("start=", start)

    if (!is.null(stop))
      stop <- paste0("stop=", stop)

    query <-
      paste(c(sites, types, sensors, start, stop), collapse = "&")

    url <-
      paste0("https://solardb.univ-reunion.fr/api/v1/data/json?",
             query)
    url %>% .getJSON

}


#' Get data from SolarDB into Xts format
#'
#' This function allow query the data from SolarDB and return the result into
#' xts format.
#'
#' @return NULL
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#'  getXtsData()
#' }
#'
getXtsData <- function(sites = NULL, types = NULL, sensors = NULL, start = NULL, stop = NULL) {
    data <- getData(sites, types, sensors, start, stop)
    lapply(data, function(ele) {
      lapply(ele, function(s)
        xts(
          s$values,
          as.POSIXct(s$dates, format = "%Y-%m-%dT%H:%M:%SZ")
        ))
    })

}
