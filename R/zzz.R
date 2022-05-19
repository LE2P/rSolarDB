.onLoad <- function(libname, pkgname){

  .baseURL <<- Sys.getenv("solardb_base_url")
  if (.baseURL ==  "")
    .baseURL <<- "https://solardb.univ-reunion.fr/api/v1/"

  .curl <<- getCurlHandle()
  tmpFile <- tempfile(); opts <- list()
  if (Sys.getenv("solardb_skip_ssl") != "")
    if (Sys.getenv("solardb_skip_ssl"))
      opts <- list(ssl.verifyhost = FALSE, ssl.verifypeer = FALSE)
  curlSetOpt(cookiejar = tmpFile, cookiefile= tmpFile, .opts = opts, curl = .curl)

  token <- Sys.getenv("solardb_token")
  if (token != "") login()

  invisible()
}
