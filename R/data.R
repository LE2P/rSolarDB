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
  url <- paste0(.baseURL, "data/sites")
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
  url <- paste0(.baseURL, "data/types")
  url %>% .getJSON

}


#' Sensors from SolarDB
#'
#' This function allow know the sensors ids from SolarDB.
#'
#' @param sites character (or character vector). List of sites
#' @param types character (or character vector). List of types
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
sensors <- function(sites = NULL, types = NULL) {
  if (!is.null(sites))
    sites <- paste0("site=", paste(sites, collapse = ","))
c
  if (!is.null(types))
    types <- paste0("type=", paste(types, collapse = ","))

  query <- paste(c(sites, types), collapse = "&")

  url <- paste0(.baseURL, "data/sensors?", query)
  url %>% .getJSON

}


#' Get data from SolarDB
#'
#' This function allow query the data from SolarDB.
#'
#' @param sites character (or character vector). List of sites
#' @param types character (or character vector). List of types
#' @param sensors character (or character vector). List of sensors
#' @param start character. Date, Timestamp or duration
#' @param stop character. Date, Timestomp or duration
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

    query <- paste(c(sites, types, sensors, start, stop), collapse = "&")

    url <- paste0(.baseURL, "data/json?", query)
    url %>% .getJSON

}


#' Get data from SolarDB into Xts format
#'
#' This function allow query the data from SolarDB and return the result into
#' xts format.
#'
#' @param sites character (or character vector). List of sites
#' @param types character (or character vector). List of types
#' @param sensors character (or character vector). List of sensors
#' @param start character. Date, Timestamp or duration
#' @param stop character. Date, Timestomp or duration
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
      lapply(ele, function(s) xts(s$values, as.POSIXct(s$dates, format = "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")))
    })

}


#' Get data from SolarDB in data.table format
#'
#' This function allow query the data from SolarDB and return the result into
#' the data.table format. The resutl will be a list of data.table by alias site.
#'
#' @param sites character (or character vector). List of sites
#' @param types character (or character vector). List of types
#' @param sensors character (or character vector). List of sensors
#' @param start character. Date, Timestamp or duration
#' @param stop character. Date, Timestomp or duration
#'
#' @return list of data.table
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#'  getDtData()
#' }
#'
getDtData <- function(sites = NULL, types = NULL, sensors = NULL, start = NULL, stop = NULL){
  d <- getData(sites, types, sensors, start, stop)

  mergeByDates <- function(...) merge(..., by = "dates", all = TRUE)

  aliasList <- names(d)
  for (a in aliasList){
    for (n in names(d[[a]])){
      names(d[[a]][[n]]) <- c("dates", n)
      d[[a]][[n]]$dates <- as.POSIXct(d[[a]][[n]]$dates, tz = "UTC", format = "%Y-%m-%dT%TZ")
    }
  }

  DT <- lapply(aliasList, function(ele) Reduce(mergeByDates, lapply(d[[ele]], as.data.table)))
  names(DT) <- aliasList

  return(DT)
}


#' Get data count by day for a sensor from SolarDB
#'
#' This function allow query the data from SolarDB.
#'
#' @param site character. Name of site
#' @param sensor character. Name of type
#'
#' @return NULL
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#'  getDataCountByDay()
#' }
#'
getDataCountByDay <- function(site , sensor) {
  qsite <- paste0("site=", site)
  qsensor <- paste0("sensorid=", sensor)
  qaggr <- "start=0&aggrFn=count&aggrEvery=24h"
  query <- paste(c(qsite, qsensor, qaggr), collapse = "&")
  url <- paste0(.baseURL, "data/json?", query)
  {url %>% .getJSON}[[site]][[sensor]]

}


#' Get data bounds from SolarDB
#'
#' This function allow query bounds date of the data from SolarDB.
#'
#' @param sites character (or character vector). List of sites
#' @param types character (or character vector). List of types
#' @param sensors character (or character vector). List of sensors
#'
#' @return NULL
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#'  getBounds()
#' }
#'
getBounds <- function(sites = NULL, types = NULL, sensors = NULL) {
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


  query <- paste(c(sites, types, sensors), collapse = "&")

  url <- paste0(.baseURL, "data/json/bounds?", query)
  url %>% .getJSON

}
