% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Lib_MapSpectralSpecies.R
\name{kmeans_progressr}
\alias{kmeans_progressr}
\title{applies results of ordination to full image based on nearest neighbors}
\usage{
kmeans_progressr(
  x,
  centers,
  iter.max,
  nstart,
  algorithm = "Hartigan-Wong",
  p = NULL
)
}
\arguments{
\item{x}{numeric. subset of spectral species distribution file}

\item{centers}{numeric. Samples selected during ordination}

\item{iter.max}{numeric. ordination of dissimilarity matrix for a selection of spatial units}

\item{nstart}{numeric. Number of partitions (repetitions) to be computed then averaged.}

\item{algorithm}{character. Name of teh algorithm}

\item{p}{function.}
}
\value{
results of kmeans
}
\description{
applies results of ordination to full image based on nearest neighbors
}
