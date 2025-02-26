#' Get JSON data from a URL
#'
#' Makes a curl request to the specified URL and returns parsed JSON data
#'
#' @param url character. URL to execute curl call
#'
#' @return list. Parsed JSON data if successful, NULL otherwise
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @importFrom RCurl getURL
#' @importFrom jsonlite fromJSON
#'
#' @examples
#' \dontrun{
#' data <- .getJSON("https://api.example.com/data")
#' }
#'
#' @noRd
.getJSON <- function(url){
  url |> getURL(curl = .curl, .encoding = 'UTF-8') |> fromJSON() |> .validateJSON()
}

#' Validate JSON response
#'
#' Validates JSON response from SolarDB API. Returns data if response code is 200
#' and data exists, otherwise prints message and returns NULL.
#'
#' @param json list. Response JSON from SolarDB API
#'
#' @return list. Response data if valid, NULL otherwise
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#' json <- list(code = 200, data = list(value = 1), message = "Success")
#' data <- .validateJSON(json)
#' }
#'
#' @noRd
.validateJSON <- function(json){
  if (json$code == 200 && !is.null(json$data)) return(json$data)
  json$message |> message()
  return(invisible(NULL))
}

#' Merge data by dates
#'
#' Merges data by dates, ensuring all dates are present in the merged result
#'
#' @param ... Data tables to merge
#'
#' @return Merged data table
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#' merged_data <- mergeByDates(data1, data2)
#' }
#'
#' @noRd
.mergeByDates <- function(...) merge(..., by = "dates", all = TRUE)


#' Convert list of data to xts format
#'
#' Converts a list of data into an xts format, with each element of the list
#' being a list of xts objects.
#'
#' @param lst list. List of data to convert
#'
#' @return List of xts objects
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#' @importFrom xts xts
#'
#' @examples
#' \dontrun{
#' xts_data <- .sdb_data_lst2xts(data)
#' }
#'
#' @noRd
.sdb_data_lst2xts <- function(lst) {
  lapply(lst, function(ele) {
    lapply(ele, function(s) xts(s$values, as.POSIXct(s$dates, format = "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")))
  })
}

#' Convert list of data to data.table format
#'
#' Converts a list of data into a data.table format, with each element of the list
#' being a data.table object.
#'
#' @param lst list. List of data to convert
#'
#' @return List of data.table objects
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#' @importFrom data.table as.data.table
#'
#' @examples
#' \dontrun{
#' dt_data <- .sdb_data_lst2dt(data)
#' }
#'
#' @noRd
.sdb_data_lst2dt <- function(lst) {

  aliasList <- names(lst)
  for (a in aliasList){
    for (n in names(lst[[a]])){
      names(lst[[a]][[n]]) <- c("dates", n)
      lst[[a]][[n]]$dates <- as.POSIXct(lst[[a]][[n]]$dates, tz = "UTC", format = "%Y-%m-%dT%TZ")
    }
  }

  DT <- lapply(aliasList, function(ele) Reduce(.mergeByDates, lapply(lst[[ele]], as.data.table)))
  names(DT) <- aliasList

  return(DT)
}


#' Apply format to data
#'
#' Applies a specified format to the data, converting it to the appropriate format
#' based on the format parameter.
#'
#' @param data list. List of data to format
#' @param format character. Format to apply (e.g. "xts", "dt")
#'
#' @return Formatted data
#'
#' @author Mathieu Delsaut, \email{mathieu.delsaut@@univ-reunion.fr}
#'
#' @examples
#' \dontrun{
#' formatted_data <- .applyFormat(data, "xts")
#' }
#'
#' @noRd
.applyFormat <- function(data, format) {
  switch(format,
    "xts" = .sdb_data_lst2xts(data),
    "data.table"  = .sdb_data_lst2dt(data),
    data  # default case returns list format
  )
}
