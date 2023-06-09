% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/db.R
\name{orderly_db_view}
\alias{orderly_db_view}
\title{Create temporary view}
\usage{
orderly_db_view(query, as, database = NULL, instance = NULL)
}
\arguments{
\item{query}{Query to create view from}

\item{as}{Name of the view in the database}

\item{database}{The name of the database. This can be omitted (or
\code{NULL}) where you only have a single database, but must be
specified if you have more than one database configured.}

\item{instance}{The instance of the database (within a given
\code{database}). This can be omitted (or \code{NULL}) where you have not
used instances or where you have only one configured.}
}
\value{
Undefined
}
\description{
Create temporary view
}
