#' Package initialization
#'
#' Sets up the SolarDB API connection parameters and authentication when the package is loaded.
#'
#' @param libname The library name
#' @param pkgname The package name
#'
#' @details
#' This function performs several initialization steps:
#' * Sets the base URL for the SolarDB API (defaults to "https://solardb.univ-reunion.fr/api/v1/")
#' * Configures curl settings for API communication
#' * Handles SSL verification settings if specified
#' * Attempts automatic login if a token is present in environment variables
#'
#' Environment variables used:
#' * solardb_base_url: Custom API base URL
#' * solardb_skip_ssl: If TRUE, skips SSL verification
#' * solardb_token: Authentication token for automatic login
#'
#' @importFrom RCurl getCurlHandle curlSetOpt
#'
#' @return None (invisible)
#'
#' @noRd
.onLoad <- function(libname, pkgname){

  .baseURL <<- Sys.getenv("solardb_base_url")
  if (.baseURL ==  "")
    .baseURL <<- "https://solardb.univ-reunion.fr/api/v1/"

  .curl <<- getCurlHandle()
  tmpFile <- tempfile(); opts <- list()
  if (Sys.getenv("solardb_skip_ssl") != "")
    if (Sys.getenv("solardb_skip_ssl"))
      opts <- list(ssl.verifyhost = FALSE, ssl.verifypeer = FALSE)
  curlSetOpt(cookiejar = tmpFile, cookiefile= tmpFile, .opts = opts, curl = .curl)

  token <- Sys.getenv("solardb_token")
  if (token != "") suppressMessages(sdb_login())

  invisible()
}
