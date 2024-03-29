% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/update.R
\name{update}
\alias{update}
\title{Update a package}
\usage{
update(packages = c(), remotes = c())
}
\arguments{
\item{packages}{Packages to update}

\item{remotes}{Remotes to update}
}
\value{
No return value
}
\description{
Update a package
}
\examples{
\dontrun{

jetpack::update("randomForest")

jetpack::update(c("randomForest", "DBI"))

jetpack::update()
}
}
