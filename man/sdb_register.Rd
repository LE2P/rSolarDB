% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/login.R
\name{sdb_register}
\alias{sdb_register}
\title{Register to SolarDB with an email}
\usage{
sdb_register(email)
}
\arguments{
\item{email}{character. The email of user}
}
\description{
This function allow to users to send an email address and obtain a token
needed to authenticate user in rSolarDB.
}
\examples{
\dontrun{
 sdb_register(email = "email@domain.com")
}

}
\author{
Mathieu Delsaut, \email{mathieu.delsaut@univ-reunion.fr}
}
