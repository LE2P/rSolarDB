#' Login to SolarDB with token
#'
#' This function allow to login to SolarDB and store the cookie needed to
#' authenticate user.
#'
#' @return NULL
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#'  login()
#' }
#'
login <- function(token = NULL){

  if (is.null(token))
    token <- Sys.getenv("solardb_token") #! load token from env

  baseUrl <- "https://solardb.univ-reunion.fr/api/v1/"
  url <- paste0(baseUrl, "login?token=", token)
  url %>% .getJSON
  return(invisible(NULL))
}


#' Logout to SolarDB
#'
#' This function allow to logout to SolarDB.
#'
#' @return NULL
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#'  logout()
#' }
#'
logout <- function(){

  url <- "https://solardb.univ-reunion.fr/api/v1/logout"
  url %>% .getJSON

  return(invisible(NULL))
}


#' Status from SolarDB
#'
#' This function allow know the login status from SolarDB.
#'
#' @return NULL
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#'  status()
#' }
#'
status <- function(){

  url <- "https://solardb.univ-reunion.fr/api/v1/status"
  url %>% .getJSON

  return(invisible(NULL))
}
