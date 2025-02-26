#' Get list of alias sites from SolarDB (Deprecated)
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated. Please use \code{sdb_sites()} instead.
#'
#' @keywords internal
#' @export
sites <- function() {
  lifecycle::deprecate_warn("1.0.0", "sites()", "sdb_sites()")
  sdb_sites()
}


#' Get list of data types from SolarDB (Deprecated)
#'
#' @description     
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated. Please use \code{sdb_types()} instead.
#'
#' @keywords internal
#' @export
types <- function() {
  lifecycle::deprecate_warn("1.0.0", "types()", "sdb_types()")
  sdb_types()
}


#' Get list of sensor IDs from SolarDB (Deprecated)
#' 
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated. Please use \code{sdb_sensors()} instead.
#'
#' @keywords internal
#' @export
sensors <- function(sites = NULL, types = NULL) {
  lifecycle::deprecate_warn("1.0.0", "sensors()", "sdb_sensors()")
  sdb_sensors(sites, types)
}


#' Query time series data from SolarDB (Deprecated)
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated. Please use \code{sdb_data()} instead.
#'
#' @keywords internal
#' @export
getData <- function(sites = NULL, types = NULL, sensors = NULL, start = NULL, stop = NULL, aggrFn = NULL, aggrEvery = NULL) { 
  lifecycle::deprecate_warn("1.0.0", "getData()", "sdb_data()")
  sdb_data(sites, types, sensors, start, stop, aggrFn, aggrEvery)
}


#' Query time series data from SolarDB in xts format (Deprecated)
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated. Please use \code{sdb_data(format = "xts")} instead.
#'
#' @keywords internal
#' @export
getXtsData <- function(sites = NULL, types = NULL, sensors = NULL, start = NULL, stop = NULL, aggrFn = NULL, aggrEvery = NULL) {
  lifecycle::deprecate_warn("1.0.0", "getXtsData()", "sdb_data(format = 'xts')")
  sdb_data(sites, types, sensors, start, stop, aggrFn, aggrEvery, format = "xts")
}


#' Query time series data from SolarDB in data.table format (Deprecated)
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated. Please use \code{sdb_data(format = "data.table")} instead.
#'
#' @keywords internal
#' @export
getDtData <- function(sites = NULL, types = NULL, sensors = NULL, start = NULL, stop = NULL, aggrFn = NULL, aggrEvery = NULL) {
  lifecycle::deprecate_warn("1.0.0", "getDtData()", "sdb_data(format = 'data.table')")
  sdb_data(sites, types, sensors, start, stop, aggrFn, aggrEvery, format = "data.table")
}


#' Get daily data count for a sensor from SolarDB (Deprecated)
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated. Please use \code{sdb_daily_counts()} instead.
#'
#' @keywords internal
#' @export
getDataCountByDay <- function(site, sensor) {
  lifecycle::deprecate_warn("1.0.0", "getDataCountByDay()", "sdb_daily_counts()")
  sdb_daily_counts(site, sensor)
}


#' Get data bounds from SolarDB (Deprecated)
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated. Please use \code{sdb_bounds()} instead.
#'
#' @keywords internal
#' @export
getBounds <- function(sites = NULL, types = NULL, sensors = NULL) {
  lifecycle::deprecate_warn("1.0.0", "getBounds()", "sdb_bounds()")
  sdb_bounds(sites, types, sensors)
}


#' Register to SolarDB with an email (Deprecated)
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated. Please use \code{sdb_register()} instead.
#'
#' @keywords internal
#' @export
register <- function(email){
  lifecycle::deprecate_warn("1.0.0", "register()", "sdb_register()")
  sdb_register(email)
}


#' Login to SolarDB with token (Deprecated)
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated. Please use \code{sdb_login()} instead.
#'
#' @keywords internal
#' @export
login <- function(token = NULL){
  lifecycle::deprecate_warn("1.0.0", "login()", "sdb_login()")  
  sdb_login(token)
}


#' Logout from SolarDB (Deprecated)
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated. Please use \code{sdb_logout()} instead.
#'
#' @keywords internal
#' @export
logout <- function(){
  lifecycle::deprecate_warn("1.0.0", "logout()", "sdb_logout()")
  sdb_logout()
}


#' Status from SolarDB (Deprecated)
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated. Please use \code{sdb_status()} instead.
#'
#' @keywords internal
#' @export
status <- function(){
  lifecycle::deprecate_warn("1.0.0", "status()", "sdb_status()")
  sdb_status()
}


#' Get Campaign Information from SolarDB (Deprecated)
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated. Please use \code{sdb_campaigns()} instead.
#'
#' @keywords internal
#' @export
campaigns <- function(id = NULL, name = NULL, territory = NULL, alias = NULL) {
  lifecycle::deprecate_warn("1.0.0", "campaigns()", "sdb_campaigns()")
  sdb_campaigns(id, name, territory, alias)
}


#' Get Instrument Information from SolarDB (Deprecated)
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated. Please use \code{sdb_instruments()} instead.
#'
#' @keywords internal
#' @export
instruments <- function(id = NULL, name = NULL, label = NULL, serial = NULL) {
  lifecycle::deprecate_warn("1.0.0", "instruments()", "sdb_instruments()")
  sdb_instruments(id, name, label, serial)
}


#' Get Measure Information from SolarDB (Deprecated)
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated. Please use \code{sdb_measures()} instead.
#'
#' @keywords internal
#' @export
measures <- function(id = NULL, names = NULL, type = NULL, nested = FALSE) {
  lifecycle::deprecate_warn("1.0.0", "measures()", "sdb_measures()")
  sdb_measures(id, names, type, nested)
}


#' Get Model Information from SolarDB (Deprecated)
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated. Please use \code{sdb_models()} instead.
#'
#' @keywords internal
#' @export
models <- function(id = NULL, name = NULL, type = NULL) {
  lifecycle::deprecate_warn("1.0.0", "models()", "sdb_models()")
  sdb_models(id, name, type)    
}


#' Launch SolarDB Missing Data Visualization App (Deprecated)
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated. Please use \code{sdb_shiny_missings()} instead.
#'
#' @keywords internal
#' @export
missings <- function() {
  lifecycle::deprecate_warn("1.0.0", "missings()", "sdb_shiny_missings()")
  sdb_shiny_missings()
}
