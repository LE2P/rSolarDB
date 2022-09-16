#' Register to SolarDB with an email
#'
#' This function allow to users to send an email address and obtain a token
#' needed to authenticate user in rSolarDB.
#'
#' @param email character. The email of user
#'
#' @return NULL
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#'  register(email = "email@domain.com")
#' }
#'
register <- function(email){

  if (!is.character(email))
    stop("email should be a character")

  url <- paste0(.baseURL, "register?email=", email)
  url %>% .getJSON
  return(invisible(NULL))
}


#' Login to SolarDB with token
#'
#' This function allow to login to SolarDB and store the cookie needed to
#' authenticate user.
#'
#' @param token character. The token to connect to SolarDB
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

  url <- paste0(.baseURL, "login?token=", token)
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

  url <- paste0(.baseURL, "logout")
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

  url <- paste0(.baseURL, "status")
  url %>% .getJSON

  return(invisible(NULL))
}
