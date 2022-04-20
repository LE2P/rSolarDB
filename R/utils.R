.onLoad <- function(libname, pkgname){
  .curl <<- RCurl::getCurlHandle()
  tmpFile <- tempfile()
  RCurl::curlSetOpt(cookiejar = tmpFile, cookiefile= tmpFile, curl = .curl)

  .baseURL <<- Sys.getenv("solardb_base_url")
  if (.baseURL ==  "")
    .baseURL <<- "https://solardb.univ-reunion.fr/api/v1/"

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
