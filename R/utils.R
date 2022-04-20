.onLoad <- function(libname, pkgname){
  .curl <<- RCurl::getCurlHandle()
  tmpFile <- tempfile()
  RCurl::curlSetOpt(cookiejar = tmpFile, cookiefile= tmpFile, curl = .curl)
}


#' getJSON
#'
#' @return NULL
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#' .getJSON()
#' }
#'
#' @export
#'
.getJSON <- function(url){
  url %>% getURL(curl = .curl) %>% fromJSON %>% .validateJSON
}

#' validateJSON
#'
#' @return NULL
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#' .getJSON()
#' }
#'
#' @export
#'
.validateJSON <- function(json){
  if (json$code == 200 && !is.null(json$data)) return(json$data)
  json$message %>% message
  return(invisible(NULL))
}
