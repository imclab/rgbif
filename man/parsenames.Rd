\name{parsenames}
\alias{parsenames}
\title{Parse taxon names using the GBIF name parser.}
\usage{
  parsenames(scientificname)
}
\arguments{
  \item{scientificname}{A character vector of scientific
  names.}
}
\value{
  A \code{data.frame} containing fields extracted from
  parsed taxon names. Fields returned are the union of
  fields extracted from all species names in
  \code{scientificname}.
}
\description{
  Parse taxon names using the GBIF name parser.
}
\examples{
\dontrun{
parsenames(scientificname='x Agropogon littoralis')
parsenames(c('Arrhenatherum elatius var. elatius',
             'Secale cereale subsp. cereale', 'Secale cereale ssp. cereale',
             'Vanessa atalanta (Linnaeus, 1758)'))
}
}
\author{
  John Baumgartner (johnbb@student.unimelb.edu.au)
}
\references{
  \url{http://www.gbif.org/developer/summary}
}

