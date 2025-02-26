#' Get list of alias sites from SolarDB
#'
#' Retrieves the list of all available site aliases from the SolarDB API.
#'
#' @return A list of site aliases
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' sdb_sites()
#'
sdb_sites <- function() {
  url <- paste0(.baseURL, "data/sites")
  url |> .getJSON()
}


#' Get list of data types from SolarDB
#'
#' Retrieves the list of all available data types from the SolarDB API.
#'
#' @return A list of data types
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' sdb_types()
#'
sdb_types <- function() {
  url <- paste0(.baseURL, "data/types")
  url |> .getJSON()
}


#' Get list of sensor IDs from SolarDB
#'
#' Retrieves the list of sensor IDs from the SolarDB API, optionally filtered by sites and types.
#'
#' @param sites character vector. List of site aliases to filter sensors
#' @param types character vector. List of data types to filter sensors
#'
#' @return A list of sensor IDs matching the filter criteria
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' all_sensors <- sdb_sensors()
#' head(all_sensors)
#'
#' marla_sensors <- sdb_sensors(sites = "marla")
#' marla_sensors
#'
#' ghi_sensors <- sdb_sensors(types = "GHI")
#' head(ghi_sensors)
#'
sdb_sensors <- function(sites = NULL, types = NULL) {
  if (!is.null(sites))
    sites <- paste0("site=", paste(sites, collapse = ","))

  if (!is.null(types))
    types <- paste0("type=", paste(types, collapse = ","))

  query <- paste(c(sites, types), collapse = "&")

  url <- paste0(.baseURL, "data/sensors?", query)
  url |> .getJSON()
}


#' Query time series data from SolarDB
#'
#' Retrieves time series data from the SolarDB API with flexible filtering and aggregation options.
#'
#' @param sites character vector. List of sites to query
#' @param types character vector. List of data types to query
#' @param sensors character vector. List of sensor IDs to query
#' @param start character. Start date/time in ISO format or duration (e.g. "-1d" for last day)
#' @param stop character. End date/time in ISO format or duration
#' @param aggrFn character. Aggregation function (e.g. "mean", "sum", "count")
#' @param aggrEvery character. Aggregation period (e.g. "1h", "1d")
#' @param format character. Format of the returned data (e.g. "list" (default), "xts", "data.table")
#'
#' @return A nested list of time series data organized by site and sensor
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' # Get raw data for last day
#' sdb_data(sites = "marla", types = "GHI", start = "-1d")
#'
#' # Get hourly averages for a date range
#' sdb_data(sensors = "GHI", start = "2023-01-01", stop = "2023-01-31",
#'   aggrFn = "mean", aggrEvery = "1h")
#'
sdb_data <- function(sites = NULL, types = NULL, sensors = NULL, start = NULL, stop = NULL, aggrFn = NULL, aggrEvery = NULL, format = "list") {
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

    if (!is.null(aggrFn))
      aggrFn <- paste0("aggrFn=", aggrFn)

    if (!is.null(aggrEvery))
      aggrEvery <- paste0("aggrEvery=", aggrEvery)

    query <- paste(c(sites, types, sensors, start, stop, aggrFn, aggrEvery), collapse = "&")

    url <- paste0(.baseURL, "data/json?", query)
    url |> .getJSON() |> .applyFormat(format)
}


#' Get daily data count for a sensor from SolarDB
#'
#' Retrieves the count of measurements per day for a specific sensor. This is useful
#' for checking data availability and completeness.
#'
#' @param site character. Site alias where the sensor is located
#' @param sensor character. Sensor ID to get counts for
#'
#' @return A list containing daily measurement counts for the specified sensor
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' # Get daily counts for a GHI sensor at MOUFIA
#' counts <- sdb_daily_counts("marla", "DHI_qn01_Avg")
#'
sdb_daily_counts <- function(site, sensor) {
  qsite <- paste0("site=", site)
  qsensor <- paste0("sensorid=", sensor)
  qaggr <- "start=0&aggrFn=count&aggrEvery=24h"
  query <- paste(c(qsite, qsensor, qaggr), collapse = "&")
  url <- paste0(.baseURL, "data/json?", query)
  {url |> .getJSON()}[[site]][[sensor]]
}


#' Get data bounds from SolarDB
#'
#' Retrieves the temporal bounds (earliest and latest timestamps) for the specified
#' data selection. This is useful for determining data availability periods.
#'
#' @param sites character vector. List of sites to check bounds for
#' @param types character vector. List of data types to check bounds for
#' @param sensors character vector. List of sensor IDs to check bounds for
#'
#' @return A list containing the earliest and latest timestamps for each site/sensor combination
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' # Get bounds for all GHI sensors
#' bnds <- sdb_bounds(types = "GHI")
#'
#' # Get bounds for specific site and sensor type
#' bnds <- sdb_bounds(sites = "marla", types = c("GHI", "DHI"))
#'
#' # Get bounds for specific sensors
#' bnds <- sdb_bounds(sensors = "WD_oo03_Avg")
#'
sdb_bounds <- function(sites = NULL, types = NULL, sensors = NULL) {
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
  url |> .getJSON()
}
