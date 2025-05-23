% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_samples_from_tiles.R
\name{get_samples_from_tiles}
\alias{get_samples_from_tiles}
\title{get samples for alpha diversity mapping}
\usage{
get_samples_from_tiles(
  plotID,
  pix2sel,
  listfiles,
  feat_list,
  as.df = F,
  as.points = F,
  xy = F,
  method = "regular",
  p = NULL
)
}
\arguments{
\item{plotID}{list.}

\item{pix2sel}{numeric.}

\item{listfiles}{character.}

\item{feat_list}{list.}

\item{as.df}{boolean.}

\item{as.points}{boolean.}

\item{xy}{boolean.}

\item{method}{character. method for terra::spatSample ('random' or 'regular')}

\item{p}{list.}
}
\value{
selpix
}
\description{
get samples for alpha diversity mapping
}
