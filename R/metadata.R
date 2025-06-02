#' Retrieve Campaign Information from SolarDB
#'
#' Fetches metadata about measurement campaigns stored in the SolarDB database.
#' You can filter results by campaign ID, name, territory, or alias. If no filter is provided, all campaigns are returned.
#'
#' @param id character. Optional. Unique campaign identifier to filter results. Default is NULL (no filter).
#' @param name character. Optional. Name of the campaign to filter results. Default is NULL (no filter).
#' @param territory character. Optional. Geographic territory of the campaign (e.g., "Reunion"). Default is NULL (no filter).
#' @param alias character. Optional. Alternative site name for the campaign. Default is NULL (no filter).
#'
#' @return A list containing campaign information matching the filters, or NULL if no match is found or on error.
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @family metadata-access
#'
#' @examples
#' # Retrieve all campaigns
#' all_campaigns <- sdb_campaigns()
#'
#' # Retrieve a campaign by name
#' marla_campaign <- sdb_campaigns(name = "marla")
#'
#' # Retrieve campaigns by territory
#' reunion_campaigns <- sdb_campaigns(territory = "Reunion")
#'
#' # Retrieve a campaign by ID
#' specific_campaign <- sdb_campaigns(id = "123")
#'
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


#' Retrieve Instrument Information from SolarDB
#'
#' Fetches metadata about measurement instruments from the SolarDB database.
#' You can filter results by instrument ID, name/model, label, or serial number. If no filter is provided, all instruments are returned.
#'
#' @param id character. Optional. Unique instrument identifier to filter results. Default is NULL (no filter).
#' @param name character. Optional. Name or model of the instrument. Default is NULL (no filter).
#' @param label character. Optional. Display label for the instrument. Default is NULL (no filter).
#' @param serial character. Optional. Serial number of the instrument. Default is NULL (no filter).
#'
#' @return A list containing instrument information matching the filters, or NULL if no match is found or on error.
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @family metadata-access
#' 
#' @examples
#' # Retrieve all instruments
#' all_instruments <- sdb_instruments()
#'
#' # Retrieve an instrument by serial number
#' specific_instrument <- sdb_instruments(serial = "SN123456")
#'
#' # Retrieve an instrument by name
#' pyranometer <- sdb_instruments(name = "PYR056")
#'
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


#' Retrieve Measure Types from SolarDB
#'
#' Fetches metadata about available measurement types from the SolarDB database.
#' Supports filtering by ID, name(s), or type, and can include nested instrument/model information.
#'
#' @param id character. Optional. Unique measure type identifier. Default is NULL (no filter).
#' @param names character or character vector. Optional. Name(s) of measure types to retrieve. Default is NULL (no filter).
#' @param type character. Optional. Category of measurement (e.g., "temperature"). Default is NULL (no filter).
#' @param nested logical. If TRUE, includes related instrument and model information. Default is FALSE.
#'
#' @return A list containing measure type information matching the filters, or NULL if no match is found or on error.
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @family metadata-access
#'
#' @examples
#' # Retrieve all measure types
#' all_measures <- sdb_measures()
#'
#' # Retrieve specific measures with nested information
#' temp_measures <- sdb_measures(names = c("temperature", "humidity"), nested = TRUE)
#'
#' # Retrieve a measure type by ID
#' specific_measure <- sdb_measures(id = "42")
#'
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


#' Retrieve Model Information from SolarDB
#'
#' Fetches metadata about instrument models from the SolarDB database.
#' You can filter results by model ID, name, or type. If no filter is provided, all models are returned.
#'
#' @param id character. Optional. Unique model identifier. Default is NULL (no filter).
#' @param name character. Optional. Name of the model. Default is NULL (no filter).
#' @param type character. Optional. Model type or category (e.g., "sensor"). Default is NULL (no filter).
#'
#' @return A list containing model information matching the filters, or NULL if no match is found or on error.
#' @export
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @family metadata-access
#'
#' @examples
#' # Retrieve all models
#' all_models <- sdb_models()
#'
#' # Retrieve models of a specific type
#' sensor_models <- sdb_models(type = "sensor")
#'
#' # Retrieve a model by name
#' specific_model <- sdb_models(name = "SPN1")
#'
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
