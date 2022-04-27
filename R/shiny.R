#' Launch missings app in the default browser
#'
#' Shiny App to visualise missing data from SolarDB
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' if (interactive()) {
#'   missings()
#' }
#' @export
#'
missings <- function() {
  appDir <- system.file("rSolarDB_Missings", package = "rSolarDB")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
  }
  runApp(appDir, display.mode = "normal")
}
