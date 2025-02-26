#' Get Campaign Information from SolarDB
#'
#' Retrieves information about measurement campaigns from the SolarDB database.
#' Allows filtering by various campaign attributes.
#'
#' @param id character. Campaign identifier
#' @param name character. Campaign name
#' @param territory character. Geographic territory of the campaign
#' @param alias character. Alternative site name
#'
#' @return list. Campaign information if successful, NULL otherwise
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' # Get all campaigns
#' all_campaigns <- sdb_campaigns()
#'
#' # Get campaign by name
#' marla_campaign <- sdb_campaigns(name = "marla")
#'
#' # Filter by territory
#' reunion_campaigns <- sdb_campaigns(territory = "Reunion")
#'
#' @export
sdb_campaigns <- function(id = NULL, name = NULL, territory = NULL, alias = NULL) {
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
  url |> .getJSON()

}


#' Get Instrument Information from SolarDB
#'
#' Retrieves information about measurement instruments from the SolarDB database.
#' Allows filtering by various instrument attributes.
#'
#' @param id character. Instrument identifier
#' @param name character. Instrument name/model
#' @param label character. Display label for the instrument
#' @param serial character. Serial number of the instrument
#'
#' @return list. Instrument information if successful, NULL otherwise
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' # Get all instruments
#' all_instruments <- sdb_instruments()
#'
#' # Get instrument by serial number
#' specific_instrument <- sdb_instruments(serial = "SN123456")
#'
#' @export
sdb_instruments <- function(id = NULL, name = NULL, label = NULL, serial = NULL) {
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
  url |> .getJSON()

}


#' Get Measure Types from SolarDB
#'
#' Retrieves information about available measurement types from the SolarDB database.
#' Supports filtering and nested data retrieval.
#'
#' @param id character. Measure type identifier
#' @param names character or character vector. Names of measure types to retrieve
#' @param type character. Category of measurement
#' @param nested logical. If TRUE, includes related instrument and model information
#'
#' @return list. Measure type information if successful, NULL otherwise
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' # Get all measure types
#' all_measures <- sdb_measures()
#'
#' # Get specific measures with nested information
#' temp_measures <- sdb_measures(
#'   names = c("temperature", "humidity"),
#'   nested = TRUE
#' )
#'
#' @export
sdb_measures <- function(id = NULL, names = NULL, type = NULL, nested = FALSE) {
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
  url |> .getJSON()

}


#' Get Model Information from SolarDB
#'
#' Retrieves information about instrument models from the SolarDB database.
#' Allows filtering by various model attributes.
#'
#' @param id character. Model identifier
#' @param name character. Model name
#' @param type character. Model type/category
#'
#' @return list. Model information if successful, NULL otherwise
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' # Get all models
#' all_models <- sdb_models()
#'
#' # Get models of specific type
#' sensor_models <- sdb_models(type = "sensor")
#'
#' @export
sdb_models <- function(id = NULL, name = NULL, type = NULL) {
  if (!is.null(id))
    id <- paste0("id=", id)

  if (!is.null(name))
    name <- paste0("name=", name)

  if (!is.null(type))
    type <- paste0("type=", type)

  query <- paste(c(id, name, type), collapse = "&")

  url <- paste0(.baseURL, "metadata/models?", query)
  url |> .getJSON()

}
