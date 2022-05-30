#' Campaigns from SolarDB
#'
#' This function allow know the campaigns from SolarDB.
#'
#' @param id character. The _id from the table campaigns
#' @param name character. The name from the table campaigns
#' @param territory character. The territory from the table campaigns
#' @param alias character. The alias site from the table campaigns
#'
#' @return NULL
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#'  campaigns()
#' }
#'
campaigns <- function(id = NULL, name = NULL, territory = NULL, alias = NULL) {
  if (!is.null(id))
    id <- paste0("id=", id)

  if (!is.null(name))
    name <- paste0("name=", name)

  if (!is.null(territory))
    territory <- paste0("territory=", territory)

  if (!is.null(alias))
    alias <- paste0("alias=", alias)

  query <- paste(c(id, name, territory, alias), collapse = "&")

  url <- paste0(.baseURL, "metadata/campaigns?", query)
  url %>% .getJSON

}


#' Instruments from SolarDB
#'
#' This function allow know the instruments from SolarDB.
#'
#' @param id character. The _id from the table instruments
#' @param name character. The name from the table instruments
#' @param label character. The label from the table instruments
#' @param serial character. The serial from the table instruments
#'
#' @return NULL
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#'  instruments()
#' }
#'
instruments <- function(id = NULL, name = NULL, label = NULL, serial = NULL) {
  if (!is.null(id))
    id <- paste0("id=", id)

  if (!is.null(name))
    name <- paste0("name=", name)

  if (!is.null(label))
    label <- paste0("label=", label)

  if (!is.null(serial))
    serial <- paste0("serial=", serial)

  query <- paste(c(id, name, label, serial), collapse = "&")

  url <- paste0(.baseURL, "metadata/instruments?", query)
  url %>% .getJSON

}


#' Measures from SolarDB
#'
#' This function allow know the measures from SolarDB.
#'
#' @param id character. The _id from the table measures
#' @param names character (or character vector). The names from the table measures
#' @param type character. The type from the table measures
#' @param nested logical. Answer should be nested from the tables measures, instruments and models
#'
#' @return NULL
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#'  measures()
#' }
#'
measures <- function(id = NULL, names = NULL, type = NULL, nested = FALSE) {
  if (!is.null(id))
    id <- paste0("id=", id)

  if (!is.null(names))
    names <- paste0("name=", paste(names, collapse = ","))

  if (!is.null(type))
    type <- paste0("type=", type)

  if (nested)
    nested <- paste0("nested=", nested)

  query <- paste(c(id, names, type, nested), collapse = "&")

  url <- paste0(.baseURL, "metadata/measures?", query)
  url %>% .getJSON

}


#' Models from SolarDB
#'
#' This function allow know the models from SolarDB.
#'
#' @param id character. The _id from the table models
#' @param name character. The name from the table models
#' @param type character. The type from the table models
#'
#' @return NULL
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#'  models()
#' }
#'
models <- function(id = NULL, name = NULL, type = NULL) {
  if (!is.null(id))
    id <- paste0("id=", id)

  if (!is.null(name))
    name <- paste0("name=", name)

  if (!is.null(type))
    type <- paste0("type=", type)

  query <- paste(c(id, name, type), collapse = "&")

  url <- paste0(.baseURL, "metadata/models?", query)
  url %>% .getJSON

}
