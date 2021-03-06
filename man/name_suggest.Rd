\name{name_suggest}
\alias{name_suggest}
\title{A quick and simple autocomplete service that returns up to 20 name usages by
doing prefix matching against the scientific name. Results are ordered by relevance.}
\usage{
  name_suggest(q = NULL, datasetKey = NULL, rank = NULL,
    fields = NULL, start = NULL, limit = 20,
    callopts = list())
}
\arguments{
  \item{callopts}{Pass on options to httr::GET for more
  refined control of http calls, and error handling}

  \item{limit}{Number of records to return}

  \item{start}{Record number to start at}

  \item{q}{Simple search parameter. The value for this
  parameter can be a simple word or a phrase. Wildcards can
  be added to the simple word parameters only, e.g.
  q=*puma*}

  \item{datasetKey}{Filters by the checklist dataset key (a
  uuid, see examples)}

  \item{rank}{The rank given as our rank enum.}

  \item{fields}{Fields to return in output data.frame
  (simply prunes columns off)}
}
\value{
  A data.frame with fields selected by fields arg.
}
\description{
  A quick and simple autocomplete service that returns up
  to 20 name usages by doing prefix matching against the
  scientific name. Results are ordered by relevance.
}
\examples{
\dontrun{
name_suggest(q='Puma concolor')
name_suggest(q='Puma')
name_suggest(q='Puma', limit=2)
name_suggest(q='Puma', fields=c('key','canonicalName'))
name_suggest(q='Puma', rank="GENUS")
}
}
\references{
  \url{http://www.gbif.org/developer/summary}
}

