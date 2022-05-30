#' getJSON
#'
#' @param url character. Url to execute curl call
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
#' @param json list. Answer json from SolarDB
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
