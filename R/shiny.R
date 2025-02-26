#' Launch SolarDB Missing Data Visualization App
#'
#' Launches a Shiny application in the default web browser that allows users to
#' visualize and analyze missing data patterns from the SolarDB database.
#'
#' @details
#' The application provides an interactive interface for exploring missing data
#' patterns in SolarDB. If the application cannot be launched due to missing
#' files, an informative error message will be displayed.
#'
#' @return None (invisible). Opens a Shiny application in the default web browser.
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @importFrom shiny runApp
#'
#' @examples
#' if (interactive()) {
#'   sdb_shiny_missings()
#' }
#'
#' @export
#'
sdb_shiny_missings <- function() {
  appDir <- system.file("rSolarDB_Missings", package = "rSolarDB")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
  }
  runApp(appDir, display.mode = "normal")
}
