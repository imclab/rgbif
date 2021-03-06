\name{country_codes}
\alias{country_codes}
\title{Look up 2 character ISO country codes}
\usage{
  country_codes(country_name, fuzzy = FALSE, ...)
}
\arguments{
  \item{country_name}{Name of country to look up}

  \item{fuzzy}{If TRUE, uses agrep to do fuzzy search on
  names.}

  \item{...}{Further arguments passed on to agrep or grep}
}
\description{
  Look up 2 character ISO country codes
}
\examples{
country_codes(country_name="United")
}

